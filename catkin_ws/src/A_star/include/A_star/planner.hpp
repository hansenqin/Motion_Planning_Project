#include <queue>
#include <vector>
#include <string>
#include <unordered_set>
#include "node.hpp"

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
    std::vector<std::vector<double>> friction_map;
    std::unordered_set<std::string> closed_set;
    std::priority_queue<Node, std::vector<Node>, Compare> open_set;

    A_star_planner(){
        
    }

    void search(){

    }

    bool verify_traj(){
        return true;
    }

};