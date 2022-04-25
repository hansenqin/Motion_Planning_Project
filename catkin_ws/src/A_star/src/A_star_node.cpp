#include <ros/ros.h>
#include <algorithm>
#include <iostream>
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

void A_star_planner::backtrack(){}
double A_star_planner::get_gcost(Node curr_node, std::string curr_trajectory_index){
    return 0;
}
double A_star_planner::get_hcost(Node node){
    return 0;
}
void A_star_planner::friction_map_cb(const A_star::friction_map& msg){
    return;
}

void A_star_planner::state_lattice_cb(const A_star::state_lattice& msg){
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
        curr_node.prev = prev;
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
            open_set.push(neighbor);
            
        }
        
    }

    auto curr_node = open_set.top();
    closed_set.insert(curr_node.get_key());
    curr_node.prev = prev;
    curr_node.trajectory_index = get_trajectory_index(node_map[prev], curr_node);

    backtrack();

    return final_trajectories;


}

int main(int argc, char** argv){
    ros::NodeHandle nh;
    A_star_planner planner;
    ros::Subscriber sub_imu = nh.subscribe("/imu/data", 1, &A_star_planner::friction_map_cb, &planner);
    return 1;
  
}
