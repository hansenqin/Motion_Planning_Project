#include <queue>
#include <vector>
#include <string>
#include <unordered_set>
#include <unordered_map>

#include "node.hpp"
#include "trajectory.hpp"
#include "A_star/state_lattice.h"
#include "A_star/trajectory_info.h"
#include "A_star/friction_map.h"

class Compare
{
public:
    bool operator() (Node a, Node b)
    {
        double a_cost = a.g_cost+a.h_cost;
        double b_cost = b.g_cost+b.h_cost;
        return a_cost > b_cost;
    }
};

class A_star_planner{
public:
    std::vector<std::vector<double>> friction_map;
    std::unordered_map<std::string, trajectory> trajectory_map;
    std::unordered_map<std::string, Node> node_map;
    std::vector<std::string> final_trajectories;

    std::unordered_set<std::string> closed_set;
    std::priority_queue<Node, std::vector<Node>, Compare> open_set;
    std::vector<int> goal;

    int min_speed;
    int max_speed;
    int num_speed_intervals = 5;
    std::vector<double> u_vec;

    //Constructors
    A_star_planner(){};
    A_star_planner(int width, int length, int min_speed_, int max_speed_,ros::NodeHandle& nh_):
        friction_map(width, std::vector<double>(length, 1)),
        min_speed(min_speed_),
        max_speed(max_speed_){
            double speed_interval = (max_speed-min_speed)/num_speed_intervals;
            for(double i=0; i <= num_speed_intervals; i++){
                u_vec.push_back(min_speed+speed_interval*i);
            }

        }
    
    // void init_subscribers(){
    //     sub_friction_map = nh.subscribe("/friction_map", 1, &A_star_planner::friction_map_cb, this);
    //     ub_state_lattice = nh.subscribe("/state_lattics", 1, &A_star_planner::state_lattics_cb, this);
    // }

    std::vector<std::string> search(int curr_x, int curr_y, double curr_u);
    std::vector<Node> get_neighbors(const Node& curr_node);
    std::string get_trajectory_index(Node parent, Node child);
    void set_trajectory_map();
    void backtrack();
    double get_gcost(Node curr_node,std::string curr_trajectory_index);
    double get_hcost(Node curr_node);
    bool verify_traj(std::string trajectory_index, Node parent_node, Node child_node);
    void friction_map_cb(const A_star::trajectory_info& msg);
    void state_lattice_cb(const A_star::state_lattice& msg);

};