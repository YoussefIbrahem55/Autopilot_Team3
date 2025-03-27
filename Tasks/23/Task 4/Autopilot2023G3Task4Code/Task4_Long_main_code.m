clc;clearvars;close all;

addpath('Functions');
addpath('Sub_Scripts');
addpath('Control_Design');

DerivativesAndData;
Aircraft_Simulator;
LonitudinalStateSpace;

states_0 = s0;

%% Transfer functions

servo            = tf(10,[1 10]);
integrator       = tf(1,[1 0]);
differentiator   = tf([1 0],1);
engine_timelag   = tf(0.1,[1 0.1]);

%% Longitudinal
FullSystem = ss(A_Long_Full,B_Long_Full,C_Long_Full,D_Long_Full);
LongSystem = ss(A_Long,B_Long,C_Long,D_Long);
ShortSystem = ss(A_Short,B_Short,C_Short,D_Short);

%Extract full linearized model transfer functions:
[~,Full_Long_u_de] = SS2TF(A_Long_Full,B_Long_Full,C_Long_Full,D_Long_Full,1,1);
[~,Full_Long_w_de] = SS2TF(A_Long_Full,B_Long_Full,C_Long_Full,D_Long_Full,1,2);
[~,Full_Long_q_de] = SS2TF(A_Long_Full,B_Long_Full,C_Long_Full,D_Long_Full,1,3);
[~,Full_Long_theta_de] = SS2TF(A_Long_Full,B_Long_Full,C_Long_Full,D_Long_Full,1,4);
[~,Full_Long_u_dT] = SS2TF(A_Long_Full,B_Long_Full,C_Long_Full,D_Long_Full,2,1);
[~,Full_Long_w_dT] = SS2TF(A_Long_Full,B_Long_Full,C_Long_Full,D_Long_Full,2,2);
[~,Full_Long_q_dT] = SS2TF(A_Long_Full,B_Long_Full,C_Long_Full,D_Long_Full,2,3);
[~,Full_Long_theta_dT] = SS2TF(A_Long_Full,B_Long_Full,C_Long_Full,D_Long_Full,2,4);

%Extract Long Mode Approximated model transfer functions:
[~,Long_Period_u_de] = SS2TF(A_Long,B_Long,C_Long,D_Long,1,1);
[~,Long_Period_theta_de] = SS2TF(A_Long,B_Long,C_Long,D_Long,1,2);
[~,Long_Period_u_dT] = SS2TF(A_Long,B_Long,C_Long,D_Long,2,1);
[~,Long_Period_theta_dT] = SS2TF(A_Long,B_Long,C_Long,D_Long,2,2);

%Extract Short Mode Approximated model transfer functions:
[~,Short_Period_w_de] = SS2TF(A_Short,B_Short,C_Short,D_Short,1,1);
[~,Short_Period_alpha_de] = SS2TF(A_Short2,B_Short2,C_Short,D_Short,1,1);
[~,Short_Period_q_de] = SS2TF(A_Short,B_Short,C_Short,D_Short,1,2);
[~,Short_Period_w_dT] = SS2TF(A_Short,B_Short,C_Short,D_Short,2,1);
[~,Short_Period_alpha_dT] = SS2TF(A_Short2,B_Short2,C_Short,D_Short,2,1);
[~,Short_Period_q_dT] = SS2TF(A_Short,B_Short,C_Short,D_Short,2,2);

%% pitch Controller 

OL_theta_thetacom = - servo * Full_Long_theta_de;

load('Long_Pitch_controller.mat');
step(CL_theta_thetacom)

%% Plotting:
% Plot1;
% Plot2;
% Plot3; 
% Plot4;
% 
% %% Plotting:
% % only one colntroller:
% DE = [1 5 10 25]*pi/180;
% for i = 1:length(DE)
%     de = DE(i);
%     dc = [0 0 de 0];
%     out = sim('Simulator_Part_1');
%     filename = 'figures';
%     Plot_de_response
% end
% 
% DT = [2000 6000 10000];
% for i = 1:length(DT)
%     dT = DT(i);
%     dc = [0 0 0 dT];
%     out = sim('Simulator_Part_1');
%     filename = 'figures';
%     Plot_dT_response
% end
% %bode_rlocus_plots;
%% Bonus Part (Compare Full linearized model to Model linearizer)

% Specify the model name
model = 'Simulator_Part_1';

% Create the analysis I/O variable IOs1
io(1) = linio('Simulator_Part_1/Demux',3,'openinput');%de
io(2) = linio('Simulator_Part_1/Demux',4,'openinput');%dth
io(3) = linio('Simulator_Part_1/Bus Selector',13,'openoutput');%alpha
io(4) = linio('Simulator_Part_1/Bus Selector',11,'openoutput');%theta
io(5) = linio('Simulator_Part_1/Bus Selector',5,'openoutput');%q
io(6) = linio('Simulator_Part_1/Bus Selector',3,'openoutput');%w
io(7) = linio('Simulator_Part_1/Bus Selector',1,'openoutput');%u

% Use the model initial condition as operating point
op = operpoint(model);

sys_ModelLinearizer = linearize(model,io,op);

[~,ModelLinearizerTF_u_de] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,1,5);
[~,ModelLinearizerTF_u_dT] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,2,5);
[~,ModelLinearizerTF_w_de] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,1,4);
[~,ModelLinearizerTF_w_dT] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,2,4);
[~,ModelLinearizerTF_alpha_de] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,1,1);
[~,ModelLinearizerTF_alpha_dT] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,2,1);
[~,ModelLinearizerTF_q_de] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,1,3);
[~,ModelLinearizerTF_q_dT] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,2,3);
[~,ModelLinearizerTF_theta_de] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,1,2);
[~,ModelLinearizerTF_theta_dT] = SS2TF(sys_ModelLinearizer.A,sys_ModelLinearizer.B,sys_ModelLinearizer.C,sys_ModelLinearizer.D,2,2);

% bode_rlocus_plots;
% Plot5;
% MergeDocuments(['Plots_Bonus.doc' 'Plots.doc'],'Plots.doc')





