% dash derivatives to normal derivatives Scritpt

%% Step 1: Compute transformation matrix G and its inverse
G = 1 / (1 - (Ixz^2 / (Ixx * Izz)));
Trans_Mat = [G, G * Ixz / Ixx; G * Ixz / Izz, G];
Trans_Mat_inv = inv(Trans_Mat);

%% Step 2: Extract aerodynamic derivatives
Yv = SD_Lat_dash(1);   % Lateral velocity derivative
Ybeta = SD_Lat_dash(2); % Sideslip angle derivative
Yda = SD_Lat_dash(9) * Vto; % Aileron control derivative
Ydr = SD_Lat_dash(10) * Vto; % Rudder control derivative

%% Step 3: Convert L_N_dash into a single vector
L_N_dash_vector = [
    SD_Lat_dash(3);  SD_Lat_dash(4);  % Beta derivatives
    SD_Lat_dash(5);  SD_Lat_dash(6);  % Roll rate derivatives
    SD_Lat_dash(7);  SD_Lat_dash(8);  % Yaw rate derivatives
    SD_Lat_dash(11); SD_Lat_dash(12); % Aileron derivatives
    SD_Lat_dash(13); SD_Lat_dash(14)  % Rudder derivatives
];

%% Step 4: Create a block diagonal transformation matrix
blk_diag_mat = blkdiag(Trans_Mat_inv, Trans_Mat_inv, Trans_Mat_inv, Trans_Mat_inv, Trans_Mat_inv);

%% Step 5: Compute LN_vector using the block diagonal matrix
LN_vector = blk_diag_mat * L_N_dash_vector;

%% Step 6: Construct the final SD_Lat vector
SD_Lat = [
    Yv;               
    Ybeta;            
    LN_vector(1:2)./Vto; % Assuming beta=v/Vto (small angle assumption)
    LN_vector(3:6);     
    Yda;             
    Ydr;             
    LN_vector(7:end)  
];
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

Yv    = SD_Lat(1);
Yb    = SD_Lat(2);
Yp=0;
Yr=0;
Lv    =SD_Lat(3);
Nv    =SD_Lat(4);
Lp    = SD_Lat(5);
Np    = SD_Lat(6);
Lr    = SD_Lat(7);
Nr    = SD_Lat(8);
Yda   = SD_Lat(9);
Ydr   = SD_Lat(10);
Lda   = SD_Lat(11);
Nda   = SD_Lat(12);
Ldr   = SD_Lat(13);
Ndr   = SD_Lat(14);
Lb_dash=SD_Lat_dash(3);
Nb_dash =SD_Lat_dash(4);
Lp_dash=SD_Lat_dash(5);
Np_dash=SD_Lat_dash(6);
Lr_dash=SD_Lat_dash(7);
Nr_dash =SD_Lat_dash(8);
Yda_star =SD_Lat_dash(9);
Ydr_star=SD_Lat_dash(10);    
Lda_dash =SD_Lat_dash(11);
Nda_dash =SD_Lat_dash(12);
Ldr_dash = SD_Lat_dash(13);
Ndr_dash= SD_Lat_dash(14);
Lv = Lb_dash ;
Nv = Nb_dash ;  
Y_p = 0 ;
Y_r = 0 ;
u0=s0(1);
v0=s0(2);
w0=s0(3);
p0=s0(4);
q0=s0(5);
r0=s0(6);
phi0=s0(7);
theta0=s0(8);
psi0=s0(9);
x0=s0(10);
y0=s0(11);
z0=s0(12);