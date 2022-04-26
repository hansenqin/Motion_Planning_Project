
struct Node{
    double g_cost = 0;
    double h_cost = 0;
    std::string prev= "";
    std::string trajectory_index = "";
    int x;
    int y;
    double u;
    
    Node(){};
    Node(int x_, int y_, double u_): x(x_), y(y_), u(u_){}

    std::string get_key() const {
        return std::to_string(x)+"-"+std::to_string(y)+"-"+std::to_string(int(u));
    }

};