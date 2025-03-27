close all;clc
%% Step Plot for Long.
%%%%%%%%%%%%% -- dT -- %%%%%%%%%%%%%%%%%

figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_u_dT   = dT* Full_Long_u_dT  + u0 ;
Long_Period_u_dT = dT*Long_Period_u_dT + u0 ;
step(Full_Long_u_dT,Long_Period_u_dT,tfinal)
hold on
title(strcat('Step Response For \delta _T = ',num2str(dT)))
plot(out.tout,out.Velocities(:,1),'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('u_d_T = ',num2str(dT),'.png')));

figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_w_dT    = dT* Full_Long_w_dT  + w0 ;
Short_Period_w_dT = dT*Short_Period_w_dT+ w0 ;
step(Full_Long_w_dT,Short_Period_w_dT,tfinal)
hold on
title(strcat('Step Response For \delta _T = ',num2str(dT)))
plot(out.tout,out.Velocities(:,3),'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('w_d_T = ',num2str(dT),'.png')));

[w_long_dT, w_time] = step(Full_Long_w_dT,(0:dt:tfinal));
[u_long_dT, ~] = step(Full_Long_u_dT,(0:dt:tfinal));
 
figure('units','normalized','outerposition',[0 0 1 1])
Short_Period_alpha_dT= (dT*Short_Period_alpha_dT + states_0(8))*180/pi;
plot(out.tout,out.alpha*180/pi,'--r','DisplayName','Non Linear')
hold on
title(strcat('Step Response For \delta _T = ',num2str(dT)))
Full_Long_alpha_dT = atan(w_long_dT./u_long_dT)*180/pi;
step(Short_Period_alpha_dT,tfinal)
plot(w_time,Full_Long_alpha_dT,'DisplayName','Full Long')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('alpha_d_T = ',num2str(dT),'.png')));

figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_q_dT    = dT* Full_Long_q_dT   + states_0(4);
Short_Period_q_dT = dT*Short_Period_q_dT + states_0(4) ;
step(Full_Long_q_dT,Short_Period_q_dT,tfinal)
hold on
title(strcat('Step Response For \delta _T = ',num2str(dT)))
plot(out.tout,out.AngularRates(:,2),'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('q_d_T = ',num2str(dT),'.png')));

figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_theta_dT    = (dT* Full_Long_theta_dT  + states_0(8))*180/pi;
Long_Period_theta_dT  = (dT*Long_Period_theta_dT + states_0(8))*180/pi;
step(Full_Long_theta_dT,Long_Period_theta_dT,tfinal)
hold on
title(strcat('Step Response For \delta _T = ',num2str(dT)))
plot(out.tout,out.EulerAngles(:,2),'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('theta_d_T = ',num2str(dT),'.png')));

close all
