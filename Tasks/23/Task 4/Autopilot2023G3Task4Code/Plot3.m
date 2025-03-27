close all;clc
%% Step Plot for Long.
%%%%%%%%%% Change this to fit the req. %%%%%%%%%%
de=10*pi/180; 
dT=10000;
dr=10*pi/180;
da=10*pi/180;

%%%%%%%%%%%%% -- de -- %%%%%%%%%%%%%%%%%
dc = [0 0 de 0]; out = sim('Simulator_Part_1');
figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_u_de   = de*Full_Long_u_de   + u0;
Long_Period_u_de = de*Long_Period_u_de + u0;
step(Full_Long_u_de,Long_Period_u_de,tfinal)
hold on
title('Step Response For 10 deg. \delta_e')
plot(out.tout,out.Velocities(:,1),'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
ylim padded
exportgraphics(gcf,'fig/u_de10_3.png')
% save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_w_de   = de* Full_Long_w_de    + w0;
Short_Period_w_de= de*Short_Period_w_de  + w0;
step(Full_Long_w_de,Short_Period_w_de,tfinal)
hold on
title('Step Response For 10 deg. \delta_e')
plot(out.tout,out.Velocities(:,3),'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
ylim padded
exportgraphics(gcf,'fig/w_de10_3.png')
% save2word('Plots_3')
hold off 

[w_long, ~] = step(Full_Long_w_de,(0:dt:tfinal));
[u_long, w_time] = step(Full_Long_u_de,(0:dt:tfinal));

figure('units','normalized','outerposition',[0 0 1 1])
Short_Period_alpha_de= (de*Short_Period_alpha_de + states_0(8))*180/pi;
plot(out.tout,out.alpha*180/pi,'--r','DisplayName','Non Linear')
hold on
title('Step Response For 10 deg. \delta_e')
Full_Long_alpha_de = atan(w_long./u_long)*180/pi;
step(Short_Period_alpha_de,tfinal)
plot(w_time,Full_Long_alpha_de,'DisplayName','Full Long')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
exportgraphics(gcf,'fig/alpha_de10_3.png')
% save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_q_de   = de* Full_Long_q_de   + states_0(4);
Short_Period_q_de= de*Short_Period_q_de + states_0(4);
step(Full_Long_q_de,Short_Period_q_de,tfinal)
hold on
title('Step Response For 10 deg. \delta_e')
plot(out.tout,out.AngularRates(:,2),'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
ylim padded
exportgraphics(gcf,'fig/q_de10_3.png')
% save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_theta_de   = (de* Full_Long_theta_de  +states_0(8))*180/pi;
Long_Period_theta_de = (de*Long_Period_theta_de +states_0(8))*180/pi;
step(Full_Long_theta_de,Long_Period_theta_de,tfinal)
hold on
title('Step Response For 10 deg. \delta_e')
plot(out.tout,out.EulerAngles(:,2)*180/pi,'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
ylim tight
exportgraphics(gcf,'fig/theta_de10_3.png')
% save2word('Plots_3')

%%%%%%%%%%%%% -- dT -- %%%%%%%%%%%%%%%%%
dc = [0 0 0 dT]; out = sim('Simulator_Part_1');
figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_u_dT   = dT* Full_Long_u_dT  + u0 ;
Long_Period_u_dT = dT*Long_Period_u_dT + u0 ;
step(Full_Long_u_dT,Long_Period_u_dT,tfinal)
hold on
title('Step Response For 10000 \delta _T')
plot(out.tout,out.Velocities(:,1),'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
ylim([300 650])
exportgraphics(gcf,'fig/u_dt10000_3.png')
% save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_w_dT    = dT* Full_Long_w_dT  + w0 ;
Short_Period_w_dT = dT*Short_Period_w_dT+ w0 ;
step(Full_Long_w_dT,Short_Period_w_dT,tfinal)
hold on
title('Step Response For 10000 \delta _T')
plot(out.tout,out.Velocities(:,3),'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;

ylim padded
exportgraphics(gcf,'fig/w_dt10000_3.png')
% save2word('Plots_3')

[w_long_dT, w_time] = step(Full_Long_w_dT,(0:dt:tfinal));
[u_long_dT, ~] = step(Full_Long_u_dT,(0:dt:tfinal));

figure('units','normalized','outerposition',[0 0 1 1])
Short_Period_alpha_dT= (dT*Short_Period_alpha_dT + states_0(8))*180/pi;
plot(out.tout,out.alpha*180/pi,'--r','DisplayName','Non Linear')
hold on
title('Step Response For 10000 \delta_T')
Full_Long_alpha_dT = atan(w_long_dT./u_long_dT)*180/pi;
step(Short_Period_alpha_dT,tfinal)
plot(w_time,Full_Long_alpha_dT,'DisplayName','Full Long')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
exportgraphics(gcf,'fig/alpha_dt10000_3.png')
% save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_q_dT    = dT* Full_Long_q_dT   + states_0(4);
Short_Period_q_dT = dT*Short_Period_q_dT + states_0(4) ;
step(Full_Long_q_dT,Short_Period_q_dT,tfinal)
hold on
title('Step Response For 10000 \delta _T')
plot(out.tout,out.AngularRates(:,2),'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
ylim padded
exportgraphics(gcf,'fig/q_dt10000_3.png')
% save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_theta_dT    = (dT* Full_Long_theta_dT  + states_0(8))*180/pi;
Long_Period_theta_dT  = (dT*Long_Period_theta_dT + states_0(8))*180/pi;
step(Full_Long_theta_dT,Long_Period_theta_dT,tfinal)
hold on
title('Step Response For 10000 \delta _T')
plot(out.tout,out.EulerAngles(:,2)*180/pi,'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
ylim tight
exportgraphics(gcf,'fig/theta_dt10000_3.png')
% save2word('Plots_3')


%% Step plot for Latr.
%{
%%%%%%%%%%%%% -- da -- %%%%%%%%%%%%%%%%%

figure('units','normalized','outerposition',[0 0 1 1])
Full_Latr_v_da        = da* Full_Latr_v_da      + states_0(2) ;
Latr_2DOF_Dutch_v_da  = da*Latr_2DOF_Dutch_v_da + states_0(2) ;
Latr_3DOF_Dutch_v_da  = da*Latr_3DOF_Dutch_v_da + states_0(2) ;
step(Full_Latr_v_da,Latr_2DOF_Dutch_v_da,Latr_3DOF_Dutch_v_da,tfinal)
hold on
title('Step Response For 10 deg. \delta _a')
plot(out.tout,out.v_10a,'--r','DisplayName','Non Linear')
xlim([0 100])
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Latr_beta_da        = (da* Full_Latr_beta_da      + states_0(2)/states_0(1))*180/pi;
Latr_2DOF_Dutch_beta_da  = (da*Latr_2DOF_Dutch_beta_da + states_0(2)/states_0(1))*180/pi;
Latr_3DOF_Dutch_beta_da  = (da*Latr_3DOF_Dutch_beta_da + states_0(2)/states_0(1))*180/pi;
step(Full_Latr_beta_da,Latr_2DOF_Dutch_beta_da,Latr_3DOF_Dutch_beta_da,tfinal)
hold on
title('Step Response For 10 deg. \delta _a')
plot(out.tout,out.beta_10a,'--r','DisplayName','Non Linear')
xlim([0 100])
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Latr_p_da        = da*Full_Latr_p_da       + states_0(4) ;
Latr_1DOF_p_da        = da*Latr_1DOF_p_da       + states_0(4) ;
Latr_3DOF_Dutch_p_da  = da*Latr_3DOF_Dutch_p_da + states_0(4) ;
step(Full_Latr_p_da,Latr_1DOF_p_da,Latr_3DOF_Dutch_p_da,tfinal)
hold on
title('Step Response For 10 deg. \delta _a')
plot(out.tout,out.p_10a,'--r','DisplayName','Non Linear')
xlim([0 100])
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Latr_r_da        = da*Full_Latr_r_da       + states_0(6);
Latr_2DOF_Dutch_r_da  = da*Latr_2DOF_Dutch_r_da + states_0(6);
Latr_3DOF_Dutch_r_da  = da*Latr_3DOF_Dutch_r_da + states_0(6);
step(Full_Latr_r_da,Latr_2DOF_Dutch_r_da,Latr_3DOF_Dutch_r_da,tfinal)
hold on
title('Step Response For 10 deg. \delta _a')
plot(out.tout,out.r_10a,'--r','DisplayName','Non Linear')
xlim([0 100])
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Latr_phi_da    = (da* Full_Latr_phi_da + states_0(7))*180/pi;
step(Full_Latr_phi_da,tfinal)
hold on
title('Step Response For 10 deg. \delta _a')
plot(out.tout,out.phi_10a,'--r','DisplayName','Non Linear')
xlim([0 100])
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Latr_psi_da    = ((da* Full_Latr_psi_da + states_0(9))*180/pi);  %%%%
step(Full_Latr_psi_da,tfinal)
hold on
title('Step Response For 10 deg. \delta _a')
plot(out.tout,unwrap(out.psi_10a),'--r','DisplayName','Non Linear')
ylim([-2000 2000])
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
save2word('Plots_3')

%%%%%%%%%%%%% -- dr -- %%%%%%%%%%%%%%%%%

figure('units','normalized','outerposition',[0 0 1 1])
Full_Latr_v_dr        = dr* Full_Latr_v_dr      + states_0(2);
Latr_2DOF_Dutch_v_dr  = dr*Latr_2DOF_Dutch_v_dr + states_0(2) ;
Latr_3DOF_Dutch_v_dr  = dr*Latr_3DOF_Dutch_v_dr + states_0(2);
step(Full_Latr_v_dr,Latr_2DOF_Dutch_v_dr,Latr_3DOF_Dutch_v_dr,tfinal)
hold on
title('Step Response For 10 deg. \delta _r')
plot(out.tout,out.v_10r,'--r','DisplayName','Non Linear')
xlim([0 50])
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Latr_beta_dr        = (dr* Full_Latr_beta_dr      + states_0(2)/states_0(1))*180/pi;
Latr_2DOF_Dutch_beta_dr  = (dr*Latr_2DOF_Dutch_beta_dr + states_0(2)/states_0(1))*180/pi ;
Latr_3DOF_Dutch_beta_dr  = (dr*Latr_3DOF_Dutch_beta_dr + states_0(2)/states_0(1))*180/pi ;
step(Full_Latr_beta_dr,Latr_2DOF_Dutch_beta_dr,Latr_3DOF_Dutch_beta_dr,tfinal)
hold on
title('Step Response For 10 deg. \delta _r')
plot(out.tout,out.beta_10r,'--r','DisplayName','Non Linear')
xlim([0 50])
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Latr_p_dr         = dr*Full_Latr_p_dr        + states_0(4);
Latr_3DOF_Dutch_p_dr   = dr*Latr_3DOF_Dutch_p_dr  + states_0(4);
Latr_3DOF_Spiral_p_dr  = dr*Latr_3DOF_Spiral_p_dr + states_0(4);
step(Full_Latr_p_dr,Latr_3DOF_Dutch_p_dr,Latr_3DOF_Spiral_p_dr,tfinal)
hold on
title('Step Response For 10 deg. \delta _r')
plot(out.tout,out.p_10r,'--r','DisplayName','Non Linear')
xlim([0 50])
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Latr_r_dr        = dr* Full_Latr_r_dr       + states_0(6);
Latr_2DOF_Dutch_r_dr  = dr*Latr_2DOF_Dutch_r_dr  + states_0(6);
Latr_3DOF_Dutch_r_dr  = dr*Latr_3DOF_Dutch_r_dr  + states_0(6);
Latr_3DOF_Spiral_r_dr = dr*Latr_3DOF_Spiral_r_dr + states_0(6);
step(Full_Latr_r_dr,Latr_2DOF_Dutch_r_dr,Latr_3DOF_Dutch_r_dr,Latr_3DOF_Spiral_r_dr,tfinal)
hold on
title('Step Response For 10 deg. \delta _r')
plot(out.tout,out.r_10r,'--r','DisplayName','Non Linear')
xlim([0 50])
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Latr_phi_dr         = dr* Full_Latr_phi_dr       * 180/pi;
Latr_3DOF_Spiral_phi_dr  = dr*Latr_3DOF_Spiral_phi_dr * 180/pi;
step(Full_Latr_phi_dr,Latr_3DOF_Spiral_phi_dr,tfinal)
hold on
title('Step Response For 10 deg. \delta _r')
plot(out.tout,out.phi_10r,'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
save2word('Plots_3')

figure('units','normalized','outerposition',[0 0 1 1])
Full_Latr_psi_dr    = (dr* Full_Latr_psi_dr *180/pi);  
step(Full_Latr_psi_dr,tfinal)
hold on
title('Step Response For 10 deg. \delta _r')
plot(out.tout,unwrap(out.psi_10r),'--r','DisplayName','Non Linear')
ylim([-1000 1000])
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
save2word('Plots_3')
%}

disp('Done, please run SS ') 
close all