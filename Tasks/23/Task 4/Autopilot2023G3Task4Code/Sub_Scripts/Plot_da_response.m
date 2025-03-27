close all;clc
%% Step plot for Latr.
%%%%%%%%%%%%% -- da -- %%%%%%%%%%%%%%%%%

figure('units','normalized','outerposition',[0 0 1 1])
Full_Lat_v_da_t        = da* Full_Lat_v_da      + states_0(2) ;
Dutch3d_v_da_t         = da*Dutch3d_v_da + states_0(2);
Dutch2d_v_da_t         = da*Dutch2d_v_da + states_0(2);
step(Full_Lat_v_da_t,Dutch3d_v_da_t,Dutch2d_v_da_t,[0:dt:tfinal])
hold on
title(strcat('Step Response For \delta _a = ',num2str(da*180/pi)))
plot(out.tout,out.Velocities(:,2),'--r','DisplayName','Non Linear')
ylim auto
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('v_d_a = ',num2str(da*180/pi),'.png')));

figure('units','normalized','outerposition',[0 0 1 1])
Full_Lat_beta_da_t        = (da* Full_Lat_beta_da      + states_0(2)/states_0(1))*180/pi;
Dutch2d_beta_da_t  = (da*Dutch2d_beta_da + states_0(2)/states_0(1))*180/pi;
Dutch3d_beta_da_t  = (da*Dutch3d_beta_da + states_0(2)/states_0(1))*180/pi;
step(Full_Lat_beta_da_t,Dutch2d_beta_da_t,Dutch3d_beta_da_t,[0:dt:tfinal])
hold on
title(strcat('Step Response For \delta _a = ',num2str(da*180/pi)))
plot(out.tout,out.beta*180/pi,'--r','DisplayName','Non Linear')
ylim auto
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('beta_d_a = ',num2str(da*180/pi),'.png')));

figure('units','normalized','outerposition',[0 0 1 1])
Full_Lat_p_da_t = (da*Full_Lat_p_da       + states_0(4))*180/pi ;
Roll_p_da_t = (da*Roll_p_da       + states_0(4))*180/pi ;
Dutch3d_p_da_t  = (da*Dutch3d_p_da + states_0(4))*180/pi ;
Spiral3d_p_da_t = (da*Spiral3d_p_da +  states_0(4))*180/pi ;
step(Full_Lat_p_da_t,Roll_p_da_t,Dutch3d_p_da_t,Spiral3d_p_da_t,[0:dt:tfinal])
hold on
title(strcat('Step Response For \delta _a = ',num2str(da*180/pi)))
plot(out.tout,out.AngularRates(:,1)*180/pi,'--r','DisplayName','Non Linear')
ylim auto
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('p_d_a = ',num2str(da*180/pi),'.png')));

figure('units','normalized','outerposition',[0 0 1 1])
Full_Lat_r_da_t        = (da*Full_Lat_r_da       + states_0(6))*180/pi;
Dutch2d_r_da_t  = (da*Dutch2d_r_da + states_0(6))*180/pi;
Dutch3d_r_da_t  = (da*Dutch3d_r_da + states_0(6))*180/pi;
Spiral3d_r_da_t  = (da*Spiral3d_r_da + states_0(6))*180/pi;
step(Full_Lat_r_da_t,Dutch2d_r_da_t,Dutch3d_r_da_t,Spiral3d_r_da_t,[0:dt:tfinal])
hold on
title(strcat('Step Response For \delta _a = ',num2str(da*180/pi)))
plot(out.tout,out.AngularRates(:,3)*180/pi,'--r','DisplayName','Non Linear')
ylim auto
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('r_d_a = ',num2str(da*180/pi),'.png')));

figure('units','normalized','outerposition',[0 0 1 1])
Full_Lat_phi_da_t = (da* Full_Lat_phi_da + states_0(7))*180/pi;
Spiral3d_phi_da_t = (da* Spiral3d_phi_da + states_0(7))*180/pi;
step(Full_Lat_phi_da_t,Spiral3d_phi_da_t,[0:dt:tfinal])
hold on
title(strcat('Step Response For \delta _a = ',num2str(da*180/pi)))
plot(out.tout,out.EulerAngles(:,1)*180/pi,'--r','DisplayName','Non Linear')
ylim auto
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('phi_d_a = ',num2str(da*180/pi),'.png')));

figure('units','normalized','outerposition',[0 0 1 1])
Full_Lat_psi_da_t    = ((da* Full_Lat_psi_da + states_0(9))*180/pi);  %%%%
step(Full_Lat_psi_da_t,[0:dt:tfinal])
hold on
title(strcat('Step Response For \delta _a = ',num2str(da*180/pi)))
plot(out.tout,unwrap(out.EulerAngles(:,3)*180/pi),'--r','DisplayName','Non Linear')
ylim auto
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('psi_d_a = ',num2str(da*180/pi),'.png')));

close all