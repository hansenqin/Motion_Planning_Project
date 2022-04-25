struct allowed_forces{
    double F_xf;
    double F_xr;
    double F_yf;
    double F_yr;
    double xi = 0.5;
    double friction;

    allowed_forces(){};
    allowed_forces(double friction_):
    friction(friction_){

    }

    


};