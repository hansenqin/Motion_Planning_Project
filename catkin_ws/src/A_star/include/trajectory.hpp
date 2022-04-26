struct trajectory{


//  float64[] inputs
// float64 max_F_xr
// float64 max_F_xf
// float64 max_F_yr
// float64 max_F_yf
// float64 t_execution
// float64 dx
// float64 dy
// float64 u1
// float64 u2
    std::vector<double> Td;
    std::vector<double> delta;
    double max_F_xf;
    double max_F_xr;
    double max_F_yr;
    double max_F_yf;
    double t_execution;
    double dx;
    double dy;
    double u1;
    double u2;
    double length;

};