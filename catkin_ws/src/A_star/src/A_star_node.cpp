#include <ros/ros.h>
#include <algorithm>
#include <iostream>
#include <cmath>
#include "planner.hpp"
#include "allowed_forces.hpp"

std::string A_star_planner::get_trajectory_index(Node parent, Node child){

    int dx = parent.x - child.x;
    int dy = parent.y - child.y;

    return std::to_string(dx)+std::to_string(dy)+std::to_string(parent.u)+std::to_string(child.u);
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
    auto curr_trajectory = trajectory_map[trajectory_index];
    int parent_x_idx = static_cast<int>(parent_node.x/4);
    int parent_y_idx = static_cast<int>(parent_node.y/4);
    int child_x_idx = static_cast<int>(child_node.x/4);
    int child_y_idx = static_cast<int>(child_node.y/4);

    double friction = std::min(friction_map[parent_x_idx][parent_y_idx], friction_map[child_x_idx][child_y_idx]);




    //TODO:

    return true;

}

void A_star_planner::backtrack(Node curr_node){
    while(curr_node.prev != ""){
        final_trajectories.push_back(curr_node.trajectory_index);
        curr_node = node_map[curr_node.prev];
    }
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
    std::cout<<"recieved friction map!"<<std::endl;
    std::vector<double> frictions = msg.frictions;
    int width = 3;
    int length = frictions.size()/width;

    int counter = 0;
    for(int i=0; i<length; i++){
        for(int j=0; j<width; j++){
            friction_map[i][j] = frictions[counter];
            counter++;
        }
    }
    return;
}

std::string A_star_planner::get_trajectory_key(A_star::trajectory_info traj){
    return std::to_string(traj.dx)+std::to_string(traj.dy)+std::to_string(traj.u1)+std::to_string(traj.u2);
}

void A_star_planner::state_lattice_cb(const A_star::state_lattice& msg){
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
    Node first_node(curr_x, curr_y, curr_u);
    // Node first_node;
    node_map[first_node.get_key()] = first_node;
    open_set.push(first_node);
    std::string prev = ""; 

    while(open_set.top().x != goal[0] && open_set.top().y != goal[1]){
        auto curr_node = open_set.top();
        closed_set.insert(curr_node.get_key());
        if(!prev.empty()){
            curr_node.trajectory_index = get_trajectory_index(node_map[prev], curr_node);
        }
        prev = curr_node.get_key();
        open_set.pop();

        auto neighbors = get_neighbors(curr_node);

        for(auto neighbor: neighbors){
            if(closed_set.count(neighbor.get_key())) continue;
            node_map[neighbor.get_key()] = neighbor;
            auto curr_trajectory_index = get_trajectory_index(curr_node, neighbor);
            if(!verify_traj(curr_trajectory_index, curr_node, neighbor)) continue;
            neighbor.g_cost = get_gcost(neighbor, curr_trajectory_index);
            neighbor.h_cost = get_hcost(neighbor);
            neighbor.prev = prev;
            open_set.push(neighbor);
            
        }
        
    }

    auto curr_node = open_set.top();
    closed_set.insert(curr_node.get_key());
    curr_node.prev = prev;
    curr_node.trajectory_index = get_trajectory_index(node_map[prev], curr_node);

    backtrack(curr_node);

    return final_trajectories;


}

int main(int argc, char** argv){
    ros::init(argc, argv, "A_star_node");
    std::cout<<"started A star node"<<std::endl;

    ros::NodeHandle nh;
    A_star_planner planner;
    ros::Subscriber sub_friction = nh.subscribe("/friction_map", 1, &A_star_planner::friction_map_cb, &planner);
    ros::Subscriber sub_state_lattice = nh.subscribe("/state_lattice", 1, &A_star_planner::state_lattice_cb, &planner);
    ros::spin();
    return 1;
  
}
