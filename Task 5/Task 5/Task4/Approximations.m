% --- Longitudinal Models ---
    % Full linear model
    A_FL = [Xu, Xw, -w0, -g*cos(theta0) ;
        Zu/(1-Zwdot), Zw/(1-Zwdot), (Zq+u0)/(1-Zwdot), (-g*sin(theta0))/(1-Zwdot);
        Mu+Mwdot*(Zu/(1-Zwdot)), Mw+Mwdot*(Zw/(1-Zwdot)), Mq+Mwdot*(Zq+u0)/(1-Zwdot), -Mwdot*(g*sin(theta0))/(1-Zwdot);
        0, 0, 1, 0];
    B_FL = [Xde, Xdth;
        Zde/(1-Zwdot), Zdth/(1-Zwdot);
        Mde+Mwdot*(Zde/(1-Zwdot)), Mdth+Mwdot*(Zdth/(1-Zwdot));
        0, 0];
    C_FL = eye(4);
    D_FL = zeros(4,2);
    sys_FL_long = ss(A_FL, B_FL, C_FL, D_FL);
    
    
    % Long period approximation
    A_LP = [Xu,          -g*cos(theta0);
            -Zu/(Zq+u0), (g*sin(theta0))/(Zq+u0)];
 
    B_LP = [Xde, Xdth;
        -Zde/(Zq+u0), -Zdth/(Zq+u0)];
    C_LP = eye(2);
    D_LP = zeros(2);
    sys_LP = ss(A_LP, B_LP, C_LP, D_LP);     
    ind_2 = [1, 10];  
    
    % Short period approximation
    A_SP = [Zw/(1-Zwdot), (Zq+u0)/(1-Zwdot);
        Mw+Mwdot*Zw/(1-Zwdot), Mq+Mwdot*(Zq+u0)/(1-Zwdot)];
    
    B_SP = [Zde/(1-Zwdot), Zdth/(1-Zwdot);
        Mde+Mwdot*Zde/(1-Zwdot), Mdth+Mwdot*Zdth/(1-Zwdot)];
    C_SP = eye(2);
    D_SP = zeros(2,2);
    sys_SP = ss(A_SP, B_SP, C_SP, D_SP);
    ind_1 = [3, 7];

% --- Lateral Models ---
    % Full Linearized Model
    A_lat = [Yb/Vto, (Yp+w0)/Vto, (Yr-u0)/Vto, (g*cos(theta0))/Vto, 0;
        Lb_dash, Lp_dash, Lr_dash, 0, 0;
        Nb_dash, Np_dash, Nr_dash, 0, 0;
        0, 1, tan(theta0), 0, 0;
        0, 0, sec(theta0), 0, 0];
    B_lat = [Yda_star, Ydr_star;
        Lda_dash, Ldr_dash;
        Nda_dash, Ndr_dash;
        0, 0;
        0, 0];
    C_lat = eye(5);
    D_lat = zeros(5,2);
    sys_FL_lat = ss(A_lat, B_lat, C_lat, D_lat);
    ind_4 = [4, 6, 8, 9, 11];
    
    % 3 DOF (Dutch Roll Approximation)
    A_DR = [Yv, 0, -1;
        Lb_dash, Lp_dash, 0;
        Nb_dash, 0, Nr_dash];
    B_DR = [Yda_star, Ydr_star;
        Lda_dash, Ldr_dash;
        Nda_dash, Ndr_dash];
    C_DR = eye(3);
    D_DR = zeros(3,2);
    sys_DR = ss(A_DR, B_DR, C_DR, D_DR);
    ind_5 = [4, 6, 8];
    
    % 3 DOF (Spiral Approximation)
    A_Sp = [Lp_dash, Lr_dash, 0;
        Np_dash, Nr_dash, 0;
        1, 0, 0];
    B_Sp = [Lda_dash  Ldr_dash
             Nda_dash  Ndr_dash
             0          0];  
    C_Sp = eye(3);
    D_Sp = zeros(3,2);
    sys_Sp = ss(A_Sp, B_Sp, C_Sp, D_Sp);
    ind_6 = [6, 8, 9];
    
    % 2 DOF Approximation
    A_2D = [Yv, -(1-Yr/u0);
        Nb_dash, Nr_dash];
    B_2D = [Yda_star, Ydr_star;
        Nda_dash, Ndr_dash];
    C_2D = eye(2);
    D_2D = zeros(2);
    sys_2D = ss(A_2D, B_2D, C_2D, D_2D);
    ind_7 = [4, 8];
    
    % 1 DOF Rolling Approximation
    A_RO = [Lp_dash];
    B_RO = [Lda_dash];
    C_RO = eye(1);
    D_RO = zeros(1);
    sys_RO = ss(A_RO, B_RO, C_RO, D_RO);
    ind_8 = 6;