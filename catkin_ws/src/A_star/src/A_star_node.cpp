#include <ros/ros.h>
#include <algorithm>
#include <iostream>
#include <cmath>
#include "planner.hpp"
#include "allowed_forces.hpp"

std::string A_star_planner::get_trajectory_index(Node parent, Node child){

    int dx = child.x - parent.x;
    int dy = child.y - parent.y;

    return std::to_string(dx)+"-"+std::to_string(dy)+"-"+std::to_string(int(parent.u))+"-"+std::to_string(int(child.u));
}

std::string A_star_planner::get_trajectory_key(A_star::trajectory_info traj){
    return std::to_string(int(traj.dx))+"-"+std::to_string(int(traj.dy))+"-"+std::to_string(int(traj.u1))+"-"+std::to_string(int(traj.u2));
}

void A_star_planner::reset(){
    friction_map = std::vector<std::vector<double>>(length, std::vector<double>(width, 1.0));
    final_trajectories.clear();
    open_set = std::priority_queue<Node, std::vector<Node>, Compare>();
    closed_set.clear();
}

std::vector<Node> A_star_planner::get_neighbors(const Node& curr_node){
    double curr_u = curr_node.u;
    double curr_x = curr_node.x;
    double curr_y = curr_node.y;
    std::vector<Node> node_vec;
    if(curr_x == 0){
        std::vector<int> x_pos_vec = {-4, 0, 4};
        for(auto x_pos:x_pos_vec){
            for(auto u:u_vec){
                node_vec.emplace_back(x_pos, curr_y+50, u);
            }
        }
    }else if(curr_x == -4){
        std::vector<int> x_pos_vec = {-4, 0};
        for(auto x_pos:x_pos_vec){
            for(auto u:u_vec){
                node_vec.emplace_back(x_pos, curr_y+50, u);
            }
        }

    }else if(curr_x == 4){
        std::vector<int> x_pos_vec = {0, 4};
        for(auto x_pos:x_pos_vec){
            for(auto u:u_vec){
                node_vec.emplace_back(x_pos, curr_y+50, u);
            }
        }
    }

    return node_vec;
}

bool A_star_planner::verify_traj(std::string trajectory_index, Node parent_node, Node child_node){
    //TODO:

    // auto curr_trajectory = trajectory_map[trajectory_index];

    int parent_x_idx = static_cast<int>((parent_node.x+4)/4);
    int parent_y_idx = static_cast<int>(parent_node.y/50);
    int child_x_idx = static_cast<int>((parent_node.x+4)/4);
    int child_y_idx = static_cast<int>(child_node.y/50);

    double friction = std::min(friction_map[parent_y_idx][parent_x_idx], friction_map[child_y_idx][child_x_idx]);

    // std::cout<<"DEBUG: friction is: "<<friction<<std::endl;
    // std::cout<<"DEBUG: parent_y_idx is: "<<parent_y_idx<<std::endl;
    // std::cout<<"DEBUG: parent_x_idx is: "<<parent_x_idx<<std::endl;
    if(friction < 0){
        std::cout<<"DEBUG: OBSTACLE"<<std::endl;
        return false;
    } 

    return true;

}

void A_star_planner::backtrack(Node curr_node){
    while(curr_node.prev != ""){
        std::cout<<"DEBUG: curr_node.prev = "<<curr_node.prev<<std::endl;
        final_trajectories.push_back(curr_node.trajectory_index);
        curr_node = closed_set[curr_node.prev];
    }
    std::reverse(final_trajectories.begin(), final_trajectories.end());
}

double A_star_planner::get_gcost(Node curr_node, std::string curr_trajectory_index){
    auto curr_trajectory = trajectory_map[curr_trajectory_index];
    return curr_node.g_cost + curr_trajectory.length + curr_trajectory.t_execution;
}

double A_star_planner::get_hcost(Node curr_node){
    double dx = abs(curr_node.x - goal[0]);
    double dy = abs(curr_node.y - goal[1]);

    return sqrt(dx*dx + dy*dy);
}

void A_star_planner::friction_map_cb(const A_star::friction_map& msg){
    A_star_planner::reset();
    std::cout<<"recieved friction map!"<<std::endl;
    std::vector<double> frictions = msg.frictions;
    int width = 3;
    int length = frictions.size()/width;

    int counter = 0;
    std::cout<<"displaying friction map values: "<<std::endl;
    for(int i=0; i<length; i++){
        for(int j=0; j<width; j++){
            friction_map[i][j] = frictions[counter];
            std::cout<<frictions[counter]<<" ";
            counter++;
        }
        std::cout<<" "<<std::endl;
    }
    std::cout<<"finished loading friction map!"<<std::endl;
    auto trajectory_to_send = A_star_planner::search(0, 0, 11);
    return;
}

void A_star_planner::state_lattice_cb(const A_star::state_lattice& msg){
    trajectory_map.clear();
    std::cout<<"recieved state lattice!"<<std::endl;
    std::vector<A_star::trajectory_info> trajectory_list;

    for(A_star::trajectory_info traj: msg.state_lattice){
        std::string key = get_trajectory_key(traj);
        trajectory_map[key] = traj;

    }
    std::cout<<"Finished loading state lattice! Totaling "<<trajectory_map.size()<<" trajectories."<<std::endl;
    return;
}

std::vector<std::string> A_star_planner::search(int curr_x, int curr_y, double curr_u){
    std::cout<<"starting A* search. Initializing..."<<std::endl;

    Node first_node(curr_x, curr_y, curr_u);
    // Node first_node;
    open_set.push(first_node);
    std::string prev = ""; 


    while(open_set.top().x != goal[0] || open_set.top().y != goal[1]){
        auto curr_node = open_set.top();
        if(closed_set.find(curr_node.get_key())!=closed_set.end()) continue;

        if(!curr_node.prev.empty()){
            curr_node.trajectory_index = get_trajectory_index(closed_set[curr_node.prev], curr_node);
            std::cout<<"DEBUG: curr_node.trajectory_index = "<<curr_node.trajectory_index<<std::endl;
        }
        closed_set[curr_node.get_key()] = curr_node;
        prev = curr_node.get_key();
        open_set.pop();

        auto neighbors = get_neighbors(curr_node);

        for(auto neighbor: neighbors){
            if(closed_set.find(neighbor.get_key())!=closed_set.end()) continue;
            auto curr_trajectory_index = get_trajectory_index(curr_node, neighbor);
            if(!verify_traj(curr_trajectory_index, curr_node, neighbor)) continue;
            neighbor.g_cost = get_gcost(neighbor, curr_trajectory_index);
            neighbor.h_cost = get_hcost(neighbor);
            neighbor.prev = prev;
            open_set.push(neighbor);
            // std::cout<<"DEBUG: neighbor.u = "<<neighbor.u<<std::endl;
            // std::cout<<"DEBUG: neighbor.g_cost = "<<neighbor.g_cost<<std::endl;
            
        }
    }

    auto curr_node = open_set.top();
    curr_node.prev = prev;
    curr_node.trajectory_index = get_trajectory_index(closed_set[prev], curr_node);
    closed_set[curr_node.get_key()] = curr_node;

    std::cout<<"Search finished, obtaining final trajectory..."<<std::endl;

    backtrack(curr_node);
    std::cout<<"Done. Final trajecory has "<<final_trajectories.size()<<" trajectories."<<std::endl;

    //Sending out stuff
    std::cout<<"Ready to send trajectory keys..."<<std::endl;
    A_star::trajectory_keys trajectory_keys_msg;
    for(auto traj: final_trajectories){
        trajectory_keys_msg.trajectory_keys.push_back(traj);
    }
    traj_key_pub_.publish(trajectory_keys_msg);
    std::cout<<"Finished sending trajectory keys."<<std::endl;
    return final_trajectories;
}

int main(int argc, char** argv){
    ros::init(argc, argv, "A_star_node");
    std::cout<<"started A star node"<<std::endl;

    ros::NodeHandle nh;
    int map_width = 3;
    int map_length = 10;
    int min_speed = 6;
    int max_speed = 16;
    int speed_intervals = 2;


    A_star_planner planner(nh, map_width, map_length, min_speed, max_speed, speed_intervals);
    planner.goal = {0, 450};
    ros::Subscriber sub_friction = nh.subscribe("/friction_map", 1, &A_star_planner::friction_map_cb, &planner);
    ros::Subscriber sub_state_lattice = nh.subscribe("/state_lattice", 1, &A_star_planner::state_lattice_cb, &planner);
    ros::spin();
    return 1;
  
}
