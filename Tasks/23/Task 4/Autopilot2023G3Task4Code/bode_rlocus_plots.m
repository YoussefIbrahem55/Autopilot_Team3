clc;close all;
%% Bode Plots -->  Longitudinal

%u
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_u_de+u0,Long_Period_u_de+u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title (' Bode Plot For u/\delta_{e} T.F ')
legend('$u / \delta_{e}_Full Longitudinal $','$u / \delta_{e}_Long Period Approx. $','interpreter','latex')
exportgraphics(gcf,'fig/bode_ude.png')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_u_dT+u0,Long_Period_u_dT+u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title (' Bode Plot For u/\delta_{th} T.F ')
legend('$u/\delta_{th}_Full Longitudinal $','$u/\delta_{th}_Long Period Approx. $','interpreter','latex')
exportgraphics(gcf,'fig/bode_udth.png')

%w
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_w_de+w0,Short_Period_w_de+w0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For w/\delta_e T.F')
legend('$w/\delta_{e}_Full Longitudinal $','$w/\delta_{e}_Short Period Approx. $','interpreter','latex')
exportgraphics(gcf,'fig/bode_wde.png')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_w_dT+w0,Short_Period_w_dT+w0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For w/\delta_{th} T.F')
legend('$w/\delta_{th}_Full Longitudinal $','$w/\delta_{th}_Short Period Approx. $','interpreter','latex')
exportgraphics(gcf,'fig/bode_wdth.png')
%alpha
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(ModelLinearizerTF_alpha_de+w0/u0,Short_Period_alpha_de+w0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \alpha/\delta_e T.F')
legend('$\alpha/\delta_{e}_Full Longitudinal $','$\alpha/\delta_{e}_Short Period Approx. $','interpreter','latex')
exportgraphics(gcf,'fig/bode_alpha_de.png')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(ModelLinearizerTF_alpha_dT+w0/u0,Short_Period_alpha_dT+w0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \alpha/\delta_{th} T.F')
legend('$\alpha/\delta_{th}_Full Longitudinal $','$\alpha/\delta_{th}_Long Period Approx. $','interpreter','latex')
exportgraphics(gcf,'fig/bode_alpha_dth.png')
%q
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_q_de+q0,Short_Period_q_de+q0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For q/\delta_e T.F')
legend('$q/\delta_{e}_Full Longitudinal $','$q/\delta_{e}_Short Period Approx.$','interpreter','latex')
exportgraphics(gcf,'fig/bode_q_de.png')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_q_dT+q0,Short_Period_q_dT+q0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For q/\delta_{th} T.F')
legend('$q/\delta_{th}_Full Longitudinal $','$q/\delta_{th}_Short Period Approx. $','interpreter','latex')
exportgraphics(gcf,'fig/bode_q_dth.png')
% theta
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_theta_de+theta0,Long_Period_theta_de+theta0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \theta/\delta_e T.F')
legend('$\theta/\delta_{e}_Full Longitudinal $','$\theta/\delta_{e}_Long Period Approx. $','interpreter','latex')
exportgraphics(gcf,'fig/bode_theta_de.png')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Long_theta_dT+theta0,Long_Period_theta_dT+theta0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \theta/\delta_{th} T.F')
legend('$\theta/\delta_{th}_Full Longitudinal $','$\theta/\delta_{th}_Long Period Approx.$','interpreter','latex')
exportgraphics(gcf,'fig/bode_theta_dth.png')
%% Bode Plots -->  Lareral
%v
%da
%{
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Latr_v_da+v0,Latr_3DOF_Dutch_v_da+v0,Latr_2DOF_Dutch_v_da+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For v/\delta_a T.F')
legend('$v/\delta_{a} Full Latr $','$v/\delta_{a} Latr 3DOF Dutch Approx. $','$v/\delta_{a} Latr 2DOF Dutch Approx. $','interpreter','latex')
%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Latr_v_dr+v0,Latr_3DOF_Dutch_v_dr+v0,Latr_2DOF_Dutch_v_dr+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For v/\delta_r T.F')
legend('$v/\delta_{r} Full Latr $','$v/\delta_{r} Latr 3DOF Dutch Approx. $','$v/\delta_{r} Latr 2DOF Dutch Approx. $','interpreter','latex')
%beta
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Latr_beta_da+v0/u0,Latr_3DOF_Dutch_beta_da+v0/u0,Latr_2DOF_Dutch_beta_da+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \beta/\delta_a T.F')
legend('$\beta/\delta_{a} Full Latr $','$\beta/\delta_{a} Latr 3DOF Dutch Approx. $','$\beta/\delta_{a} Latr 2DOF Dutch Approx. $','interpreter','latex')
%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Latr_beta_dr+v0/u0,Latr_3DOF_Dutch_beta_dr+v0/u0,Latr_2DOF_Dutch_beta_dr+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \beta/\delta_{r} T.F')
legend('$\beta/\delta_{r} Full Latr $','$\beta/\delta_{r} Latr 3DOF Dutch Approx. $','$\beta/\delta_{r} Latr 2DOF Dutch Approx. $','interpreter','latex')
%p
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Latr_p_da+p0,Latr_3DOF_Dutch_p_da+p0,Latr_1DOF_p_da+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For p/\delta_{a} T.F')
legend('$p/\delta_{a} Full Latr $','$p/\delta_{a} Latr 3DOF Dutch Approx. $','$p/\delta_{a} Latr 1DOF Roll Approx. $','interpreter','latex')
%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Latr_p_dr+p0,Latr_3DOF_Dutch_p_da+p0,Latr_3DOF_Spiral_p_dr+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For p/\delta_{r} T.F')
legend('$p/\delta_{r} Full Latr $','$p/\delta_{r} Latr 3DOF Dutch Approx. $','$p/\delta_{r} Latr 3DOF Spiral Approx. $','interpreter','latex')
%r
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Latr_r_da+r0,Latr_3DOF_Dutch_r_da+r0,Latr_2DOF_Dutch_r_da+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For r/\delta_{a} T.F')
legend('$r/\delta_{a} Full Latr $','$r/\delta_{a} Latr 3DOF Dutch Approx. $','$r/\delta_{a} Latr 2DOF Dutch Approx. $','interpreter','latex')
%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Latr_r_dr+r0,Latr_3DOF_Dutch_r_dr+r0,Latr_2DOF_Dutch_r_dr+r0,Latr_3DOF_Spiral_r_dr+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For r/\delta_{r} T.F')
legend('$r/\delta_{r} Full Latr $','$r/\delta_{r} Latr 3DOF Dutch Approx. $','$r/\delta_{r} Latr 2DOF Dutch Approx. $','$r/\delta_{r} Latr 3DOF Spiral Approx. $','interpreter','latex')
%phi
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Latr_phi_da+phi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \phi/\delta_{a} T.F')
legend('$\phi/\delta_{a} Full Latr $','interpreter','latex')
%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Latr_phi_dr+phi0,Latr_3DOF_Spiral_phi_dr+phi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \phi/\delta_{r} T.F')
legend('$\phi/\delta_{r} Full Latr $','$\alpha/\delta_{r} Latr 3DOF Spiral Approx. $','interpreter','latex')
%psi
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Latr_psi_da+psi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \psi/\delta_{a} T.F')
legend('$\psi/\delta_{a} Full Latr $','interpreter','latex')
%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
bode(Full_Latr_psi_dr+psi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Bode Plot For \psi/\delta_{r} T.F')
legend('$\psi/\delta_{r} Full Latr $','interpreter','latex')
%}
%% Root Locus Plots -->  Longitudinal
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
exportgraphics(gcf,'fig/RL_ude.png')
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
exportgraphics(gcf,'fig/RL_udth.png')
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
exportgraphics(gcf,'fig/RL_wde.png')
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
exportgraphics(gcf,'fig/RL_wdth.png')
%alpha
%de
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(ModelLinearizerTF_alpha_de+w0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\alpha/\delta_{e}_Full Longitudinal $','interpreter','latex')
subplot(1,2,2)
rlocus(Short_Period_alpha_de+w0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For \alpha/\delta_e T.F')
legend('$\alpha/\delta_{e}_Short Period Approx. $','interpreter','latex')
exportgraphics(gcf,'fig/RL_alpha_de.png')
%dth
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(ModelLinearizerTF_alpha_dT+w0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\alpha/\delta_{th}_Full Longitudinal $','interpreter','latex')
subplot(1,2,2)
rlocus(Short_Period_alpha_dT+w0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For \alpha/\delta_{th} T.F')
legend('$\alpha/\delta_{th}_Long Period Approx. $','interpreter','latex')
exportgraphics(gcf,'fig/RL_alpha_dth.png')
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
exportgraphics(gcf,'fig/RL_qde.png')
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
exportgraphics(gcf,'fig/RL_qdth.png')
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
exportgraphics(gcf,'fig/RL_theta_de.png')
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
exportgraphics(gcf,'fig/RL_theta_dth.png')

%{
%% Root Locus Plots -->  Lareral
%v
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_v_da+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$v/\delta_{a} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_3DOF_Dutch_v_da+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For v/\delta_a T.F')
legend('$v/\delta_{a} Latr 3DOF Dutch Approx. $','interpreter','latex')
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_v_da+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$v/\delta_{a} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_2DOF_Dutch_v_da+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For v/\delta_a T.F')
legend('$v/\delta_{a} Latr 2DOF Dutch Approx. $','interpreter','latex')
%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_v_dr+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$v/\delta_{r} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_3DOF_Dutch_v_dr+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For v/\delta_r T.F')
legend('$v/\delta_{r} Latr 3DOF Dutch Approx. $','interpreter','latex')
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_v_dr+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$v/\delta_{r} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_2DOF_Dutch_v_dr+v0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For v/\delta_r T.F')
legend('$v/\delta_{r} Latr 2DOF Dutch Approx. $','interpreter','latex')
%beta
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_beta_da+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\beta/\delta_{a} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_3DOF_Dutch_beta_da+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For \beta/\delta_a T.F')
legend('$\beta/\delta_{a} Latr 3DOF Dutch Approx. $','interpreter','latex')
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_beta_da+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\beta/\delta_{a} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_2DOF_Dutch_beta_da+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For \beta/\delta_a T.F')
legend('$\beta/\delta_{a} Latr 2DOF Dutch Approx. $','interpreter','latex')
%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_beta_dr+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\beta/\delta_{r} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_3DOF_Dutch_beta_dr+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For \beta/\delta_{r} T.F')
legend('$\beta/\delta_{r} Latr 3DOF Dutch Approx. $','interpreter','latex')
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_beta_dr+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\beta/\delta_{r} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_2DOF_Dutch_beta_dr+v0/u0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For \beta/\delta_{r} T.F')
legend('$\beta/\delta_{r} Latr 2DOF Dutch Approx. $','interpreter','latex')
%p
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_p_da+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$p/\delta_{a} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_3DOF_Dutch_p_da+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For p/\delta_{a} T.F')
legend('$p/\delta_{a} Latr 3DOF Dutch Approx. $','interpreter','latex')
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_p_da+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$p/\delta_{a} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_1DOF_p_da+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For p/\delta_{a} T.F')
legend('$p/\delta_{a} Latr 1DOF Roll Approx. $','interpreter','latex')
save2word('Plots4')
%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_p_dr+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$p/\delta_{r} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_3DOF_Dutch_p_da+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For p/\delta_{r} T.F')
legend('$p/\delta_{r} Latr 3DOF Dutch Approx. $','interpreter','latex')
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_p_dr+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$p/\delta_{r} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_3DOF_Spiral_p_dr+p0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For p/\delta_{r} T.F')
legend('$p/\delta_{r} Latr 3DOF Spiral Approx. $','interpreter','latex')
%r
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_r_da+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$r/\delta_{a} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_3DOF_Dutch_r_da+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For r/\delta_{a} T.F')
legend('$r/\delta_{a} Latr 3DOF Dutch Approx. $','interpreter','latex')
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_r_da+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$r/\delta_{a} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_2DOF_Dutch_r_da+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For r/\delta_{a} T.F')
legend('$r/\delta_{a} Latr 2DOF Dutch Approx. $','interpreter','latex')
%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_r_dr+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$r/\delta_{r} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_3DOF_Dutch_r_dr+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For r/\delta_{r} T.F')
legend('$r/\delta_{r} Latr 3DOF Dutch Approx. $','interpreter','latex')
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_r_dr+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$r/\delta_{r} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_2DOF_Dutch_r_dr+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For r/\delta_{r} T.F')
legend('$r/\delta_{r} Latr 2DOF Dutch Approx. $','interpreter','latex')
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_r_dr+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$r/\delta_{r} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_3DOF_Spiral_r_dr+r0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For r/\delta_{r} T.F')
legend('$r/\delta_{r} Latr 2DOF Spiral Approx. $','interpreter','latex')


%phi
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
rlocus(Full_Latr_phi_da+phi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Root Locus Plot For \phi/\delta_{a} T.F')
legend('$\phi/\delta_{a} Full Latr $','interpreter','latex')
%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
rlocus(Full_Latr_phi_dr+phi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
legend('$\phi/\delta_{r} Full Latr $','interpreter','latex')
subplot(1,2,2)
rlocus(Latr_3DOF_Spiral_phi_dr+phi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
sgtitle ('Root Locus Plot For \phi/\delta_{r} T.F')
legend('$\alpha/\delta_{r} Latr 3DOF Spiral Approx. $','interpreter','latex')
% 
%psi
%da
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
rlocus(Full_Latr_psi_da+psi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Root Locus Plot For \psi/\delta_{a} T.F')
legend('$\psi/\delta_{a} Full Latr $','interpreter','latex')
%dr
figure('NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
rlocus(Full_Latr_psi_dr+psi0);
set(findall(gcf,'type','line'),'linewidth',1.5);grid on ;
title ('Root Locus Plot For \psi/\delta_{r} T.F')
legend('$\psi/\delta_{r} Full Latr $','interpreter','latex')

%}

