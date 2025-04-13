function states_dot = get_states_dot(t,states_vec)

W = 636636 ;
g = 32.17405 ;
m = W/g ;
Vt0 = 518 ;
Ixx = 1.82E+07 ;
Iyy = 3.31E+07 ;
Izz = 4.97E+07 ;
Ixz = 9.70E+05 ;
Ixy = 0 ;
Iyz = 0 ;
I = [Ixx , -Ixy , -Ixz ;...
    -Ixy , Iyy , -Iyz ;...
    -Ixz , -Iyz , Izz];

delta_E = 0 ;
delta_E0 = 0 ;
delta_TH = 0;
delta_TH0 =0 ;
delta_A  = 0;
delta_A0 = 0;
delta_R = 0;
delta_R0 = 0;


%Reference conditions 
u0 = 514.3561332 ;
v0 = 0 ;
w0 = 61.333255558 ;

p0 = 0 ;
q0 = 0 ;
r0 = 0 ;

phi0 = 0 ; 
ceta0 = 1.19e-01 ; 
psi0 = 0 ;

X0 = 0 ;
Y0 = 0;
Z0 = -2e+04;

X_0 = W*sin(ceta0) ;             % Refernce force in x-direction
Y_0 = -W*cos(ceta0)*sin(phi0) ;  % Refernce force in z-direction
Z_0 = -W*cos(ceta0)*cos(phi0) ;  % Refernce force in z-direction

L_0 = 0 ;
M_0 = 0 ;
N_0 = 0 ;
%--------------Naming the states----------------------%
u = states_vec(1);
v= states_vec(2);
w= states_vec(3);

p= states_vec(4);
q= states_vec(5);
r= states_vec(6);

phi= states_vec(7);
ceta= states_vec(8);
psi= states_vec(9);
eul = [phi ceta psi] ;

X= states_vec(10);
Y= states_vec(11);
Z= states_vec(12);



%--------------------LONGITUDINAL Deravitves--------------------%
XU = -2.47E-03;   %(1/sec)
ZU = -6.79E-02;  %(1/sec)
MU = 2.47E-04;   %(1/sec-ft)
XW = 7.82E-02;   %(1/sec)
ZW = -4.33E-01;   %(1/sec)
MW = -1.70E-03;   %(1/sec-ft)
ZWD  =	1.57E-02; %(1/sec^2)
ZQ  = -6.39E+00;  %(1/sec)
MWD = -1.25E-04; %(1/sec-ft)
MQ = -4.21E-01; %(1/sec)
XDE = 2.02E+00; %(ft/sec^2 rad)
ZDE = -1.69E+01; %(ft/sec^2 rad)
MDE =  - 1.09E+00;     %(1/sec^2)
XD_TH =	 5.05E-05;
ZD_TH = -2.20E-06;
MD_TH =	 3.02E-07;

%--------------------LATERAL Deravitves--------------------%
YV  = -8.22E-02; %(1/sec)
YB  = -4.26E+01; %(ft/sec^2)
LB_dash  =	-2.05E+00 ; %(1/sec^2)
NB_dash  =	4.19E-01; %(1/sec^2)
LP_dash  =	-6.52E-01; %(1/sec)
NP_dash  =	-7.01E-02; %(1/sec)
LR_dash  =	3.76E-01;  %(1/sec)
NR_dash  =	-1.40E-01; %(1/sec)
YDA_star =	0.00E+00 ;  %(1/sec)
YDR_star = 1.31E-02 ;  %(1/sec)
YDA = YDA_star *Vt0 ;   %(ft/sec^2)
YDR = YDR_star *Vt0 ;   %(ft/sec^2)
LDA_dash  =	1.28E-01 ;  %(1/sec^2)
NDA_dash  =	1.77E-02 ;  %(1/sec^2)
LDR_dash  =	1.48E-01 ;  %(1/sec^2)
NDR_dash  =	-3.81E-01 ; %(1/sec^2)

%--------------------Convertion From Dash --------------------%
G = 1/(1-(Ixz^2/Ixx*Izz)) ;
Dash_Mat = [G G*Ixz/Ixx ; G*Ixz/Izz G] ;
 
 Beta_Mat = inv(Dash_Mat) *[LB_dash ; NB_dash ] ;
 LB = Beta_Mat(1) ;
 NB = Beta_Mat(2) ;

 P_Mat = inv(Dash_Mat) *[LP_dash ; NP_dash ] ;
 LP = P_Mat(1) ;
 NP = P_Mat(2) ;

 R_Mat = inv(Dash_Mat) *[LR_dash ; NR_dash ] ;
 LR = R_Mat(1) ;
 NR = R_Mat(2) ;

 DA_Mat = inv(Dash_Mat) *[LDA_dash ; NDA_dash ] ;
 LDA = DA_Mat(1) ;
 NDA = DA_Mat(2) ;

 DR_Mat = inv(Dash_Mat) *[LDR_dash ; NDR_dash ] ;
 LDR = DR_Mat(1) ;
 NDR = DR_Mat(2) ;

 %-----------Calculating The Forces and Moments----------------------%
Delta_X = m*(XU * (u-u0) + XW*(w-w0) +XDE*(delta_E-delta_E0) +XD_TH*(delta_TH-delta_TH0));
Delta_Y =m*( YV * (v-v0) + 0*(p-p0) +0*(r-r0) +YDR*(delta_R-delta_R0));
Delta_Z = m*(ZU * (u-u0) + ZW*(w-w0) + ZQ*(q-q0) +ZDE*(delta_E-delta_E0) +ZD_TH*(delta_TH-delta_TH0));

Delta_L = m*(0* (v-v0) + LP*(p-p0) +LR*(r-r0) +LDR*(delta_R-delta_R0) +LDA*(delta_A-delta_A0));
Delta_M = m*(MU * (u-u0) + MW*(w-w0) + MQ*(q-q0) +MDE*(delta_E-delta_E0) + MD_TH*(delta_TH-delta_TH0));
Delta_N = m*(0 * (v-v0) + NP*(p-p0) +NR*(r-r0) +NDR*(delta_R-delta_R0) +NDA*(delta_A-delta_A0));

% Total Forces 
F_X = Delta_X+X_0 - W*sin(ceta) ;
F_Y = Delta_Y+Y_0 + W*cos(ceta)*sin(phi) ;
F_Z = (Delta_Z+Z_0+ W*cos(ceta)*cos(phi))/(1-ZWD) ;


F = [ F_X ; F_Y ; F_Z ] ;
Mom = [Delta_L ; Delta_M/(1-MWD) ; Delta_N ] ;



%-----------Calculating The States dot----------------------%
states_dot (1:3,1) = (1/m)*F-cross([p;q;r],[u;v;w]) ;

states_dot (4:6,1) = inv(I)*[Mom-cross([p;q;r],I*[p;q;r])] ;

states_dot (7:9,1) = [1, sin(phi)*tan(ceta), cos(phi)*tan(ceta) ; 0, cos(phi), -sin(phi) ; 0, sin(phi)/cos(ceta), cos(phi)/cos(ceta)] * [p;q;r];

states_dot (10:12,1) =  eul2rotm(eul,"ZYX")*[u;v;w];


states_dot = states_dot (1:12,1);

end