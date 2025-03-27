% this script convert dash to normal derivitavies

G=1/(1-(Ixz^2/(Ixx*Izz)));

Trans_Mat=[G G*Ixz/Ixx;G*Ixz/Izz G];
Trans_Mat_inv=inv(Trans_Mat);

Y_dr_star = SD_Lat_dash(10);
Y_da_star = SD_Lat_dash(9);

Y_v = SD_Lat_dash(1);
Y_beta = SD_Lat_dash(2);
Y_da = Y_da_star*Vto;
Y_dr = Y_dr_star*Vto;

L_beta_dash = SD_Lat_dash(3);
L_p_dash = SD_Lat_dash(5);
L_r_dash = SD_Lat_dash(7);
L_dr_dash = SD_Lat_dash(13);
L_da_dash = SD_Lat_dash(11);

N_beta_dash = SD_Lat_dash(4); 
N_p_dash = SD_Lat_dash(6);
N_r_dash = SD_Lat_dash(8);
N_dr_dash = SD_Lat_dash(14);
N_da_dash = SD_Lat_dash(12);


LN_v = Trans_Mat_inv*[L_beta_dash;N_beta_dash]./Vto;
LN_p = Trans_Mat_inv*[L_p_dash;N_p_dash];
LN_r = Trans_Mat_inv*[L_r_dash;N_r_dash];
LN_dr =Trans_Mat_inv*[L_dr_dash;N_dr_dash];
LN_da =Trans_Mat_inv*[L_da_dash;N_da_dash];

SD_Lat = [Y_v LN_v(1) LN_v(2) LN_p(1) LN_p(2) LN_r(1) LN_r(2) Y_da Y_dr LN_da(1) LN_da(2) LN_dr(1) LN_dr(2)]';