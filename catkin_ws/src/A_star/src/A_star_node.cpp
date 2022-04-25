#include <ros/ros.h>
#include <iostream>
#include "planner.hpp"

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
    // if(curr_x == 0){
    //     std::vector<int> x_pos_vec = {-4, 0, 4};
    //     for(auto x_pos:x_pos_vec){
    //         for(auto u:u_vec){
    //             node_vec.emplace_back(x_pos, curr_y+50, u);
    //         }
    //     }
    // }else if(curr_x == -4){
    //     std::vector<int> x_pos_vec = {-4, 0};
    //     for(auto x_pos:x_pos_vec){
    //         for(auto u:u_vec){
    //             node_vec.emplace_back(x_pos, curr_y+50, u);
    //         }
    //     }

    // }else if(curr_x == 4){
    //     std::vector<int> x_pos_vec = {0, 4};
    //     for(auto x_pos:x_pos_vec){
    //         for(auto u:u_vec){
    //             node_vec.emplace_back(x_pos, curr_y+50, u);
    //         }
    //     }
    // }

    return node_vec;
}

bool A_star_planner::verify_traj(std::string trajectory_index){
    auto curr_trajectory = trajectory_map[trajectory_index];

    //TODO:

    return true;

}

void A_star_planner::backtrack(){}


std::vector<std::string> A_star_planner::search(int curr_x, int curr_y, double curr_u){
    // Node first_node(curr_x, curr_y, curr_u);
    Node first_node;
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
            if(!verify_traj(curr_trajectory_index)) continue;
            // neighbor.g_cost = get_gcost(curr_node);
            // neighbor.h_cost = get_hcost(curr_node);
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
    return 1;
  
}
