clc;clearvars;close all;

addpath('Functions');
addpath('Sub_Scripts');

DerivativesAndData;
Aircraft_Simulator;

LateralStateSpace;

states_0 = s0;

%% Laterals Models
Full_Lat_System = ss(A_Lat_Full,B_Lat_Full,C_Lat_Full,D_Lat_Full);
Spiral3dSystem  = ss(A_Spiral3,B_Spiral3,C_Spiral3,D_Spiral3);
Dutch3dSystem   = ss(A_Dutch3,B_Dutch3,C_Dutch3,D_Dutch3);
Dutch2dSystem   = ss(A_Dutch2,B_Dutch2,C_Dutch2,D_Dutch2);
RolldSystem     = ss(A_Roll,B_Roll,C_Roll,D_Roll);
 
%Extract full linearized model transfer functions:
[~,Full_Lat_v_da] = SS2TF(A_Lat_Full_v,B_Lat_Full_v,C_Lat_Full,D_Lat_Full,1,1);

[~,Full_Lat_beta_da] = SS2TF(A_Lat_Full,B_Lat_Full,C_Lat_Full,D_Lat_Full,1,1);
[~,Full_Lat_p_da]    = SS2TF(A_Lat_Full,B_Lat_Full,C_Lat_Full,D_Lat_Full,1,2);
[~,Full_Lat_r_da]    = SS2TF(A_Lat_Full,B_Lat_Full,C_Lat_Full,D_Lat_Full,1,3);
[~,Full_Lat_phi_da]  = SS2TF(A_Lat_Full,B_Lat_Full,C_Lat_Full,D_Lat_Full,1,4);
[~,Full_Lat_psi_da]  = SS2TF(A_Lat_Full,B_Lat_Full,C_Lat_Full,D_Lat_Full,1,5);

[~,Full_Lat_v_dr] = SS2TF(A_Lat_Full_v,B_Lat_Full_v,C_Lat_Full,D_Lat_Full,2,1);

[~,Full_Lat_beta_dr] = SS2TF(A_Lat_Full,B_Lat_Full,C_Lat_Full,D_Lat_Full,2,1);
[~,Full_Lat_p_dr]    = SS2TF(A_Lat_Full,B_Lat_Full,C_Lat_Full,D_Lat_Full,2,2);
[~,Full_Lat_r_dr]    = SS2TF(A_Lat_Full,B_Lat_Full,C_Lat_Full,D_Lat_Full,2,3);
[~,Full_Lat_phi_dr]  = SS2TF(A_Lat_Full,B_Lat_Full,C_Lat_Full,D_Lat_Full,2,4);
[~,Full_Lat_psi_dr]  = SS2TF(A_Lat_Full,B_Lat_Full,C_Lat_Full,D_Lat_Full,2,5);

%Extract Spiral3d Mode Approximated model transfer functions:
[~,Spiral3d_p_da]   = SS2TF(A_Spiral3,B_Spiral3,C_Spiral3,D_Spiral3,1,1);
[~,Spiral3d_r_da]   = SS2TF(A_Spiral3,B_Spiral3,C_Spiral3,D_Spiral3,1,2);
[~,Spiral3d_phi_da] = SS2TF(A_Spiral3,B_Spiral3,C_Spiral3,D_Spiral3,1,3);
[~,Spiral3d_p_dr]   = SS2TF(A_Spiral3,B_Spiral3,C_Spiral3,D_Spiral3,2,1);
[~,Spiral3d_r_dr]   = SS2TF(A_Spiral3,B_Spiral3,C_Spiral3,D_Spiral3,2,2);
[~,Spiral3d_phi_dr] = SS2TF(A_Spiral3,B_Spiral3,C_Spiral3,D_Spiral3,2,3);

%Extract Dutch3d Mode Approximated model transfer functions:
[~,Dutch3d_v_da] = SS2TF(A_Dutch3_v,B_Dutch3_v,C_Dutch3,D_Dutch3,1,1);
[~,Dutch3d_beta_da] = SS2TF(A_Dutch3,B_Dutch3,C_Dutch3,D_Dutch3,1,1);
[~,Dutch3d_p_da]    = SS2TF(A_Dutch3,B_Dutch3,C_Dutch3,D_Dutch3,1,2);
[~,Dutch3d_r_da]    = SS2TF(A_Dutch3,B_Dutch3,C_Dutch3,D_Dutch3,1,3);
[~,Dutch3d_v_dr] = SS2TF(A_Dutch3_v,B_Dutch3_v,C_Dutch3,D_Dutch3,2,1);
[~,Dutch3d_beta_dr] = SS2TF(A_Dutch3,B_Dutch3,C_Dutch3,D_Dutch3,2,1);
[~,Dutch3d_p_dr]    = SS2TF(A_Dutch3,B_Dutch3,C_Dutch3,D_Dutch3,2,2);
[~,Dutch3d_r_dr]    = SS2TF(A_Dutch3,B_Dutch3,C_Dutch3,D_Dutch3,2,3);

%Extract Dutch2d Mode Approximated model transfer functions:
[~,Dutch2d_v_da] = SS2TF(A_Dutch2_v,B_Dutch2_v,C_Dutch2,D_Dutch2,1,1);
[~,Dutch2d_beta_da] = SS2TF(A_Dutch2,B_Dutch2,C_Dutch2,D_Dutch2,1,1);
[~,Dutch2d_r_da]    = SS2TF(A_Dutch2,B_Dutch2,C_Dutch2,D_Dutch2,1,2);
[~,Dutch2d_v_dr] = SS2TF(A_Dutch2_v,B_Dutch2_v,C_Dutch2,D_Dutch2,2,1);
[~,Dutch2d_beta_dr] = SS2TF(A_Dutch2,B_Dutch2,C_Dutch2,D_Dutch2,2,1);
[~,Dutch2d_r_dr]    = SS2TF(A_Dutch2,B_Dutch2,C_Dutch2,D_Dutch2,2,2);


%Extract Roll1d Mode Approximated model transfer functions:
[~,Roll_p_da] = SS2TF(A_Roll,B_Roll,C_Roll,D_Roll,1,1);


%% Plotting:
% only one controller:
DA = [1 5 10 25]*pi/180;
for i = 1:length(DA)
    da = DA(i);
    dc = [da 0 0 0];
    out = sim('Simulator_Part_1');
    filename = 'figures\Lateral Results\delta_a';
    Plot_da_response
end

DR = [1 5 10 25]*pi/180;
for i = 1:length(DR)
    dr = DR(i);
    dc = [0 dr 0 0];
    out = sim('Simulator_Part_1');
    filename = 'figures\Lateral Results\delta_r';
    Plot_dr_response
end

Bode_filename = 'figures\Lateral Results\Bode Plots';
RL_filename = 'figures\Lateral Results\Root Locus';
bode_rlocus_plots
close all;
%% Bonus Part (Compare Full linearized model to Model linearizer)

% Specify the model name
model = 'Simulator_Part_1';

% Create the analysis I/O variable IOs1

io(1) = linio('Simulator_Part_1/Demux',2,'openinput'); %dr
io(2) = linio('Simulator_Part_1/Demux',1,'openinput'); %da
io(3) = linio('Simulator_Part_1/Bus Selector',12,'openoutput');%psi
io(4) = linio('Simulator_Part_1/Bus Selector',10,'openoutput'); %phi
io(5) = linio('Simulator_Part_1/Bus Selector',6,'openoutput'); %r
io(6) = linio('Simulator_Part_1/Bus Selector',4,'openoutput'); %p
io(7) = linio('Simulator_Part_1/Bus Selector',2,'openoutput'); %v
io(8) = linio('Simulator_Part_1/Bus Selector',14,'openoutput'); %beta

% Use the model initial condition as operating point
op = operpoint(model);

sys_ModelLinearizer = linearize(model,io,op);

[~,ModelLinearizerTF_v_da] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,2,5);
[~,ModelLinearizerTF_beta_da] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,2,6);
[~,ModelLinearizerTF_p_da] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,2,4);
[~,ModelLinearizerTF_r_da] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,2,3);
[~,ModelLinearizerTF_phi_da] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,2,2);
[~,ModelLinearizerTF_psi_da] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,2,1);

[~,ModelLinearizerTF_v_dr] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,1,5);
[~,ModelLinearizerTF_beta_dr] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,1,6);
[~,ModelLinearizerTF_p_dr] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,1,4);
[~,ModelLinearizerTF_r_dr] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,1,3);
[~,ModelLinearizerTF_phi_dr] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,1,2);
[~,ModelLinearizerTF_psi_dr] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,1,1);
