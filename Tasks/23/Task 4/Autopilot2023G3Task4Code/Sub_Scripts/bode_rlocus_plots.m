clc;close all;
%% Bode Plots -->  Longitudinal
%{
%u
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_u_de+u0,Long_Period_u_de+u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title (' Bode Plot For u/\delta_{e} T.F ')
legend('$u / \delta_{e}_Full Longitudinal $','$u / \delta_{e}_Long Period Approx. $','interpreter','latex')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_u_dT+u0,Long_Period_u_dT+u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title (' Bode Plot For u/\delta_{th} T.F ')
legend('$u/\delta_{th}_Full Longitudinal $','$u/\delta_{th}_Long Period Approx. $','interpreter','latex')

%w
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_w_de+w0,Short_Period_w_de+w0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For w/\delta_e T.F')
legend('$w/\delta_{e}_Full Longitudinal $','$w/\delta_{e}_Short Period Approx. $','interpreter','latex')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_w_dT+w0,Short_Period_w_dT+w0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For w/\delta_{th} T.F')
legend('$w/\delta_{th}_Full Longitudinal $','$w/\delta_{th}_Short Period Approx. $','interpreter','latex')
%alpha
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_alpha_de+w0/u0,Short_Period_alpha_de+w0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \alpha/\delta_e T.F')
legend('$\alpha/\delta_{e}_Full Longitudinal $','$\alpha/\delta_{e}_Short Period Approx. $','interpreter','latex')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_alpha_dT+w0/u0,Short_Period_alpha_dT+w0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \alpha/\delta_{th} T.F')
legend('$\alpha/\delta_{th}_Full Longitudinal $','$\alpha/\delta_{th}_Long Period Approx. $','interpreter','latex')
%q
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_q_de+q0,Short_Period_q_de+q0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For q/\delta_e T.F')
legend('$q/\delta_{e}_Full Longitudinal $','$q/\delta_{e}_Short Period Approx.$','interpreter','latex')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_q_dT+q0,Short_Period_q_dT+q0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For q/\delta_{th} T.F')
legend('$q/\delta_{th}_Full Longitudinal $','$q/\delta_{th}_Short Period Approx. $','interpreter','latex')
% theta
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_theta_de+theta0,Long_Period_theta_de+theta0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \theta/\delta_e T.F')
legend('$\theta/\delta_{e}_Full Longitudinal $','$\theta/\delta_{e}_Long Period Approx. $','interpreter','latex')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_theta_dT+theta0,Long_Period_theta_dT+theta0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \theta/\delta_{th} T.F')
legend('$\theta/\delta_{th}_Full Longitudinal $','$\theta/\delta_{th}_Long Period Approx.$','interpreter','latex')
%}
%% Bode Plots -->  Lareral
%v
%da

figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Lat_v_da+v0,Dutch2d_v_da+v0,Dutch3d_v_da+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For v/\delta_a T.F')
legend('$v/\delta_{a} Full Lat $','$v/\delta_{a} Dutch 3DOF $','$v/\delta_{a} Dutch 2DOF $','interpreter','latex')
saveas(gcf,fullfile(Bode_filename,'v_d_a.png'));

%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Lat_v_dr+v0,Dutch2d_v_dr+v0,Dutch3d_v_dr+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For v/\delta_r T.F')
legend('$v/\delta_{r} Full Lat $','$v/\delta_{r} Dutch 3DOF $','$v/\delta_{r} Dutch 2DOF $','interpreter','latex')
saveas(gcf,fullfile(Bode_filename,'v_d_r.png'));


%beta
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Lat_beta_da+v0/u0,Dutch3d_beta_da+v0/u0,Dutch2d_beta_da+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \beta/\delta_a T.F')
legend('$\beta/\delta_{a} Full Lat $','$\beta/\delta_{a} Lat 3DOF Dutch Approx. $','$\beta/\delta_{a} Lat 2DOF Dutch Approx. $','interpreter','latex')
saveas(gcf,fullfile(Bode_filename,'beta_d_a.png'));

%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Lat_beta_dr+v0/u0,Dutch3d_beta_dr+v0/u0,Dutch2d_beta_dr+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \beta/\delta_{r} T.F')
legend('$\beta/\delta_{r} Full Lat $','$\beta/\delta_{r} Lat 3DOF Dutch Approx. $','$\beta/\delta_{r} Lat 2DOF Dutch Approx. $','interpreter','latex')
saveas(gcf,fullfile(Bode_filename,'beta_d_r.png'));


%p
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Lat_p_da+p0,Spiral3d_p_da+p0,Dutch3d_p_da+p0,Roll_p_da+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For p/\delta_{a} T.F')
legend('$p/\delta_{a} Full Lat $','$p/\delta_{a} 3DOF Spiral Approx. $','$p/\delta_{a} Lat 3DOF Dutch Approx. $','$p/\delta_{a} Lat 1DOF Roll Approx. $','interpreter','latex')
saveas(gcf,fullfile(Bode_filename,'p_d_a.png'));


%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Lat_p_dr+p0,Spiral3d_p_dr+p0,Dutch3d_p_dr+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For p/\delta_{r} T.F')
legend('$p/\delta_{r} Full Lat $','$p/\delta_{r} 3DOF Spiral Approx. $','$p/\delta_{r} Lat 3DOF Dutch Approx. $','interpreter','latex')
saveas(gcf,fullfile(Bode_filename,'p_d_r.png'));


%r
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Lat_r_da+r0,Spiral3d_r_da+r0,Dutch3d_r_da+r0,Dutch2d_r_da+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For r/\delta_{a} T.F')
legend('$r/\delta_{a} Full Lat $','$r/\delta_{a} 3DOF Spiral Approx. $','$r/\delta_{a} Lat 3DOF Dutch Approx. $','$r/\delta_{a} Lat 2DOF Dutch Approx. $','interpreter','latex')
saveas(gcf,fullfile(Bode_filename,'r_d_a.png'));

%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Lat_r_dr+r0,Spiral3d_r_dr+r0,Dutch3d_r_da+r0,Dutch2d_r_dr+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For r/\delta_{r} T.F')
legend('$r/\delta_{r} Full Lat $','$r/\delta_{r} 3DOF Spiral Approx. $','$r/\delta_{r} Lat 3DOF Dutch Approx. $','$r/\delta_{r} Lat 2DOF Dutch Approx. $','$r/\delta_{r} Lat 3DOF Spiral Approx. $','interpreter','latex')
saveas(gcf,fullfile(Bode_filename,'r_d_r.png'));


%phi
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Lat_phi_da+phi0,Spiral3d_phi_da+phi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \phi/\delta_{a} T.F')
legend('$\phi/\delta_{a} Full Lat $','$\phi/\delta_{a} Lat 3DOF Spiral Approx. $','interpreter','latex')
saveas(gcf,fullfile(Bode_filename,'phi_d_a.png'));

%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Lat_phi_dr+phi0,Spiral3d_phi_dr+phi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \phi/\delta_{r} T.F')
legend('$\phi/\delta_{r} Full Lat $','$\phi/\delta_{r} Lat 3DOF Spiral Approx. $','interpreter','latex')
saveas(gcf,fullfile(Bode_filename,'phi_d_r.png'));


%psi
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Lat_psi_da+psi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \psi/\delta_{a} T.F')
legend('$\psi/\delta_{a} Full Lat $','interpreter','latex')
saveas(gcf,fullfile(Bode_filename,'psi_d_a.png'));

%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Lat_psi_dr+psi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \psi/\delta_{r} T.F')
legend('$\psi/\delta_{r} Full Lat $','interpreter','latex')
saveas(gcf,fullfile(Bode_filename,'psi_d_r.png'));

%% Root Locus Plots -->  Longitudinal
%{
%u
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Long_u_de+u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$u / \delta_{e}_Full Longitudinal $','interpreter','latex')
subplot(1,2,2)
rlocus(Long_Period_u_de+u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$u / \delta_{e}_Long Period Approx. $','interpreter','latex')
sgtitle (' Root Locus Plot For u/\delta_{e} T.F ')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Long_u_dT+u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$u / \delta_{th}_Full Longitudinal $','interpreter','latex')
subplot(1,2,2)
rlocus(Long_Period_u_dT+u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$u / \delta_{th}_Long Period Approx. $','interpreter','latex')
sgtitle (' Root Locus Plot For u/\delta_{th} T.F ')
%w
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Long_w_de+w0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$w/\delta_{e}_Full Longitudinal $','interpreter','latex')
subplot(1,2,2)
rlocus(Short_Period_w_de+w0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For w/\delta_e T.F')
legend('$w/\delta_{e}_Short Period Approx. $','interpreter','latex')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Long_w_dT+w0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$w/\delta_{th}_Full Longitudinal $','interpreter','latex')
subplot(1,2,2)
rlocus(Short_Period_w_dT+w0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For w/\delta_{th} T.F')
legend('$w/\delta_{th}_Short Period Approx. $','interpreter','latex')
%alpha
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Long_alpha_de+w0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\alpha/\delta_{e}_Full Longitudinal $','interpreter','latex')
subplot(1,2,2)
rlocus(Short_Period_alpha_de+w0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For \alpha/\delta_e T.F')
legend('$\alpha/\delta_{e}_Short Period Approx. $','interpreter','latex')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Long_alpha_dT+w0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\alpha/\delta_{th}_Full Longitudinal $','interpreter','latex')
subplot(1,2,2)
rlocus(Short_Period_alpha_dT+w0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For \alpha/\delta_{th} T.F')
legend('$\alpha/\delta_{th}_Long Period Approx. $','interpreter','latex')
%q
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Long_q_de+q0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$q/\delta_{e}_Full Longitudinal $','interpreter','latex')
subplot(1,2,2)
rlocus(Short_Period_q_de+q0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For q/\delta_e T.F')
legend('$q/\delta_{e}_Short Period Approx.$','interpreter','latex')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Long_q_dT+q0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$q/\delta_{th}_Full Longitudinal $','interpreter','latex')
subplot(1,2,2)
rlocus(Short_Period_q_dT+q0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For q/\delta_{th} T.F')
legend('$q/\delta_{th}_Short Period Approx. $','interpreter','latex')
% theta
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Long_theta_de+theta0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\theta/\delta_{e}_Full Longitudinal $','interpreter','latex')
subplot(1,2,2)
rlocus(Long_Period_theta_de+theta0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For \theta/\delta_e T.F')
legend('$\theta/\delta_{e}_Long Period Approx. $','interpreter','latex')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Long_theta_dT+theta0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\theta/\delta_{th}_Full Longitudinal $','interpreter','latex')
subplot(1,2,2)
rlocus(Long_Period_theta_dT+theta0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For \theta/\delta_{th} T.F')
legend('$\theta/\delta_{th}_Long Period Approx.$','interpreter','latex')
%}
%% Root Locus Plots -->  Lareral
%v
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,3,1)
rlocus(Full_Lat_v_da+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$v/\delta_{a} Full Lat $','interpreter','latex')
sgtitle ('$ Root Locus Plot For v/\delta_a T.F $','interpreter','latex')
subplot(1,3,2)
rlocus(Dutch3d_v_da+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$v/\delta_{a} Dutch 3DOF $','interpreter','latex')
subplot(1,3,3)
rlocus(Dutch2d_v_da+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$v/\delta_{a} Dutch 2DOF $','interpreter','latex')
saveas(gcf,fullfile(RL_filename,'v_d_a.png'));

%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,3,1)
rlocus(Full_Lat_v_dr+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$v/\delta_{r} Full Lat $','interpreter','latex')
sgtitle ('$ Root Locus Plot For v/\delta_r T.F $','interpreter','latex')
subplot(1,3,2)
rlocus(Dutch3d_v_dr+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$v/\delta_{r} Dutch 3DOF $','interpreter','latex')
subplot(1,3,3)
rlocus(Dutch2d_v_dr+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$v/\delta_{r} Dutch 2DOF $','interpreter','latex')
saveas(gcf,fullfile(RL_filename,'v_d_r.png'));

%beta
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,3,1)
rlocus(Full_Lat_beta_da+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\beta/\delta_{a} Full Lat $','interpreter','latex')
subplot(1,3,2)
rlocus(Dutch3d_beta_da+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For \beta/\delta_a T.F')
legend('$\beta/\delta_{a} Lat 3DOF Dutch Approx. $','interpreter','latex')
subplot(1,3,3)
rlocus(Dutch2d_beta_da+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\beta/\delta_{a} Lat 2DOF Dutch Approx. $','interpreter','latex')
saveas(gcf,fullfile(RL_filename,'beta_d_a.png'));

%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,3,1)
rlocus(Full_Lat_beta_dr+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\beta/\delta_{r} Full Lat $','interpreter','latex')
subplot(1,3,2)
rlocus(Dutch3d_beta_dr+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For \beta/\delta_r T.F')
legend('$\beta/\delta_{r} Lat 3DOF Dutch Approx. $','interpreter','latex')
subplot(1,3,3)
rlocus(Dutch2d_beta_dr+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\beta/\delta_{r} Lat 2DOF Dutch Approx. $','interpreter','latex')
saveas(gcf,fullfile(RL_filename,'beta_d_r.png'));


%p
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)
rlocus(Full_Lat_p_da+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$p/\delta_{a} Full Lat $','interpreter','latex')
subplot(2,2,2)
rlocus(Dutch3d_p_da+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For p/\delta_{a} T.F')
legend('$p/\delta_{a} Lat 3DOF Dutch Approx. $','interpreter','latex')
subplot(2,2,3)
rlocus(Spiral3d_p_da+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$p/\delta_{a} Spiral_3d $','interpreter','latex')
subplot(2,2,4)
rlocus(Roll_p_da+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For p/\delta_{a} T.F')
legend('$p/\delta_{a} Lat 1DOF Roll Approx. $','interpreter','latex')
saveas(gcf,fullfile(RL_filename,'p_d_a.png'));

%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,3,1)
rlocus(Full_Lat_p_dr+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$p/\delta_{r} Full Lat $','interpreter','latex')
subplot(1,3,2)
rlocus(Dutch3d_p_dr+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For p/\delta_{r} T.F')
legend('$p/\delta_{r} Lat 3DOF Dutch Approx. $','interpreter','latex')
subplot(1,3,3)
rlocus(Spiral3d_p_dr+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$p/\delta_{r} Spiral_3d $','interpreter','latex')
saveas(gcf,fullfile(RL_filename,'p_d_r.png'));


%r
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)
rlocus(Full_Lat_r_da+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$r/\delta_{a} Full Lat $','interpreter','latex')
subplot(2,2,2)
rlocus(Dutch3d_r_da+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For r/\delta_{a} T.F')
legend('$r/\delta_{a} Lat 3DOF Dutch Approx. $','interpreter','latex')
subplot(2,2,3)
rlocus(Spiral3d_r_da+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$r/\delta_{a} 3DOF Spiral $','interpreter','latex')
subplot(2,2,4)
rlocus(Dutch2d_r_da+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$r/\delta_{a} Lat 2DOF Dutch Approx. $','interpreter','latex')
saveas(gcf,fullfile(RL_filename,'r_d_a.png'));


%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)
rlocus(Full_Lat_r_dr+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$r/\delta_{r} Full Lat $','interpreter','latex')
subplot(2,2,2)
rlocus(Dutch3d_r_dr+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For r/\delta_{r} T.F')
legend('$r/\delta_{r} Lat 3DOF Dutch Approx. $','interpreter','latex')
subplot(2,2,3)
rlocus(Spiral3d_r_dr+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$r/\delta_{r} 3DOF Spiral $','interpreter','latex')
subplot(2,2,4)
rlocus(Dutch2d_r_dr+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$r/\delta_{r} Lat 2DOF Dutch Approx. $','interpreter','latex')
saveas(gcf,fullfile(RL_filename,'r_d_r.png'));


%phi
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Lat_phi_da+phi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Root Locus Plot For \phi/\delta_{a} T.F')
legend('$\phi/\delta_{a} Full Lat $','interpreter','latex')
subplot(1,2,2)
rlocus(Spiral3d_phi_da+phi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Root Locus Plot For \phi/\delta_{a} T.F')
legend('$\phi/\delta_{a} 3DOF Spiral $','interpreter','latex')
saveas(gcf,fullfile(RL_filename,'phi_d_a.png'));

%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Lat_phi_dr+phi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Root Locus Plot For \phi/\delta_{r} T.F')
legend('$\phi/\delta_{r} Full Lat $','interpreter','latex')
subplot(1,2,2)
rlocus(Spiral3d_phi_dr+phi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Root Locus Plot For \phi/\delta_{r} T.F')
legend('$\phi/\delta_{r} 3DOF Spiral $','interpreter','latex')
saveas(gcf,fullfile(RL_filename,'phi_d_r.png'));


%psi
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
rlocus(Full_Lat_psi_da+psi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Root Locus Plot For \psi/\delta_{a} T.F')
legend('$\psi/\delta_{a} Full Lat $','interpreter','latex')
saveas(gcf,fullfile(RL_filename,'psi_d_a.png'));

%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
rlocus(Full_Lat_psi_dr+psi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Root Locus Plot For \psi/\delta_{r} T.F')
legend('$\psi/\delta_{r} Full Lat $','interpreter','latex')
saveas(gcf,fullfile(RL_filename,'psi_d_r.png'));



