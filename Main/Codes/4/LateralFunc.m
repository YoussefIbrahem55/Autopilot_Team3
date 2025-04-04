% dash derivatives to normal derivatives Scritpt

%% Step 1: Compute transformation matrix G and its inverse
G = 1 / (1 - (Ixz^2 / (Ixx * Izz)));
Trans_Mat = [G, G * Ixz / Ixx; G * Ixz / Izz, G];
Trans_Mat_inv = inv(Trans_Mat);

%% Step 2: Extract aerodynamic derivatives
Y_v = SD_Lat_dash(1);   % Lateral velocity derivative
Y_beta = SD_Lat_dash(2); % Sideslip angle derivative
Y_da = SD_Lat_dash(9) * Vto; % Aileron control derivative
Y_dr = SD_Lat_dash(10) * Vto; % Rudder control derivative

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
    Y_v;               
    Y_beta;            
    LN_vector(1:2)./Vto; % Assuming beta=v/Vto (small angle assumption)
    LN_vector(3:6);     
    Y_da;             
    Y_dr;             
    LN_vector(7:end)  
];