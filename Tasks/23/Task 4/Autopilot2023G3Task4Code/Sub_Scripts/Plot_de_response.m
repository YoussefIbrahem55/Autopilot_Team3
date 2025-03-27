close all;clc
%% Step Plot for Long.
%%%%%%%%%%%%% -- de -- %%%%%%%%%%%%%%%%%

figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_u_de   = de*Full_Long_u_de   + u0;
Long_Period_u_de = de*Long_Period_u_de + u0;
step(Full_Long_u_de,Long_Period_u_de,tfinal)
hold on
title(strcat('Step Response For \delta _e = ',num2str(de*180/pi),' deg. '))
plot(out.tout,out.Velocities(:,1),'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('u_d_e = ',num2str(de*180/pi),'.png')));


figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_w_de   = de* Full_Long_w_de    + w0;
Short_Period_w_de= de*Short_Period_w_de  + w0;
step(Full_Long_w_de,Short_Period_w_de,tfinal)
hold on
title(strcat('Step Response For \delta _e = ',num2str(de*180/pi),' deg. '))
plot(out.tout,out.Velocities(:,3),'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('w_d_e = ',num2str(de*180/pi),'.png')));

[w_long_de, ~] = step(Full_Long_w_de,(0:dt:tfinal));
[u_long_de, w_time] = step(Full_Long_u_de,(0:dt:tfinal));

figure('units','normalized','outerposition',[0 0 1 1])
Short_Period_alpha_de= (de*Short_Period_alpha_de + states_0(8))*180/pi;
plot(out.tout,out.alpha*180/pi,'--r','DisplayName','Non Linear')
hold on
title(strcat('Step Response For \delta _e = ',num2str(de*180/pi),' deg. '))
Full_Long_alpha_de = atan(w_long_de./u_long_de)*180/pi;
step(Short_Period_alpha_de,tfinal)
plot(w_time,Full_Long_alpha_de,'DisplayName','Full Long')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('alpha_d_e = ',num2str(de*180/pi),'.png')));

figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_q_de   = de* Full_Long_q_de   + states_0(4);
Short_Period_q_de= de*Short_Period_q_de + states_0(4);
step(Full_Long_q_de,Short_Period_q_de,tfinal)
hold on
title(strcat('Step Response For \delta _e = ',num2str(de*180/pi),' deg. '))
plot(out.tout,out.AngularRates(:,2),'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('q_d_e = ',num2str(de*180/pi),'.png')));

figure('units','normalized','outerposition',[0 0 1 1])
Full_Long_theta_de   = (de* Full_Long_theta_de  +states_0(8))*180/pi;
Long_Period_theta_de = (de*Long_Period_theta_de +states_0(8))*180/pi;
step(Full_Long_theta_de,Long_Period_theta_de,tfinal)
hold on
title(strcat('Step Response For \delta _e = ',num2str(de*180/pi),' deg. '))
plot(out.tout,out.EulerAngles(:,2),'--r','DisplayName','Non Linear')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
saveas(gcf,fullfile(filename,strcat('theta_d_e = ',num2str(de*180/pi),'.png')));

close all
