struct allowed_forces{
    double F_x;
    double F_y;

    allowed_forces(){};
    allowed_forces(double F_x_, double F_y_):
    F_x(F_x_),
    F_y(F_y_){}
};