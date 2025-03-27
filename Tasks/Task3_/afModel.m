
function [F, M,stabilityDerivatives,controlsDerivatives ]=afModel(SD_Long_final,SD_Lat_final,cuStates,states0,in,m,g,I)
% ACModel
 Ixx = I(1);
    Iyy = I(5);
    Izz = I(9);

Xu    = SD_Long_final(1);
Xw    = SD_Long_final(4);
Xde   = SD_Long_final(11);
Xdth  = SD_Long_final(14);
Zu    = SD_Long_final(2);
Zw    = SD_Long_final(5); 
Zwdot = SD_Long_final(7);
Zq    = SD_Long_final(8);
Zde   = SD_Long_final(12);
Zdth  = SD_Long_final(15);
Mu    = SD_Long_final(3);
Mw    = SD_Long_final(6);
Mwdot = SD_Long_final(9);
Mq    = SD_Long_final(10);
Mde   = SD_Long_final(13);
Mdth  = SD_Long_final(16);

% Lateral Stability Derivatives

Yv    = SD_Lat_final(1);
Yb    = SD_Lat_final(2);
Yp=0;
Yr=0;
Lv    =SD_Lat_final(3);
Nv    =SD_Lat_final(4);
Lp    = SD_Lat_final(5);
Np    = SD_Lat_final(6);
Lr    = SD_Lat_final(7);
Nr    = SD_Lat_final(8);
Yda   = SD_Lat_final(9);
Ydr   = SD_Lat_final(10);
Lda   = SD_Lat_final(11);
Nda   = SD_Lat_final(12);
Ldr   = SD_Lat_final(13);
Ndr   = SD_Lat_final(14);

%deltas

du    = cuStates(1)-states0(1);
dv    = cuStates(2)-states0(2);
dw    = cuStates(3)-states0(3);
dp    = cuStates(4)-states0(4);
dq    = cuStates(5)-states0(5);
dr    = cuStates(6)-states0(6);
dwdot = cuStates(13)-states0(13);

d_da    = in(1);
d_dr    = in(2);
d_de    = in(3);
d_dth   = in(4);



% Stability Derivatives matrix
dstates=[du dv dw dp dq dr dwdot]';
stabilityDerivatives=[  Xu 0 Xw 0 0 0  0
                        0 Yv 0 Yp 0 Yr 0
                        Zu 0 Zw 0 Zq 0 Zwdot
                        0 Lv 0 Lp 0 Lr 0
                        Mu 0 Mw 0 Mq 0 Mwdot
                        0 Nv 0 Np 0 Nr  0       ];
% Control Matrix

dcontrols = [d_da d_de d_dth d_dr]';
% dcontrols = [d_da d_dr d_de d_dth]';

controlsDerivatives = [0    Xde   Xdth   0
                       Yda  0     0      Ydr
                       0    Zde   Zdth   0
                       Lda  0     0      Ldr
                       0    Mde   Mdth   0
                       Nda  0     0      Ndr];

delta=stabilityDerivatives*dstates + controlsDerivatives*dcontrols;

delta_F = m*delta(1:3);
delta_M = [Ixx;Iyy;Izz].*delta(4:6);

gravity0 = [m*g*sin(states0(8))
    -m*g*cos(states0(8))*sin(states0(7))
    -m*g*cos(states0(8))*cos(states0(7))];
gravity = [ -m*g*sin(cuStates(8))
            m*g*cos(cuStates(8))*sin(cuStates(7))
            m*g*cos(cuStates(8))*cos(cuStates(7))];
F = delta_F + gravity0 + gravity;
M = delta_M ;

