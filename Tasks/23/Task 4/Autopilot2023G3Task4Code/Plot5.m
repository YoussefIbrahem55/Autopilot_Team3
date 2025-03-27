close all;clc
%%
figure('units','normalized','outerposition',[0 0 1 1])
step(Full_Long_u_de,ModelLinearizerTF_u_de,tfinal)
hold on
title('Step Response For 1 deg. \delta _e')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
% save2word('Plots_Bonus')

figure('units','normalized','outerposition',[0 0 1 1])
step(Full_Long_u_dT,ModelLinearizerTF_u_dT,tfinal)
hold on
title('Step Response For 1 deg. \delta _e')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
% save2word('Plots_Bonus')

figure('units','normalized','outerposition',[0 0 1 1])
step(Full_Long_w_de,ModelLinearizerTF_w_de,tfinal)
hold on
title('Step Response For 1 deg. \delta _e')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
% save2word('Plots_Bonus')

figure('units','normalized','outerposition',[0 0 1 1])
step(Full_Long_w_dT,ModelLinearizerTF_w_dT,tfinal)
hold on
title('Step Response For 1 deg. \delta _e')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
% save2word('Plots_Bonus')

% figure('units','normalized','outerposition',[0 0 1 1])
% step(Full_Long_alpha_de,ModelLinearizerTF_alpha_de,tfinal)
% hold on
% title('Step Response For 1 deg. \delta _e')
% set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
% % save2word('Plots_Bonus')

% figure('units','normalized','outerposition',[0 0 1 1])
% step(Full_Long_alpha_dT,ModelLinearizerTF_alpha_dT,tfinal)
% hold on
% title('Step Response For 1 deg. \delta _e')
% set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
% % save2word('Plots_Bonus')

figure('units','normalized','outerposition',[0 0 1 1])
step(Full_Long_q_de,ModelLinearizerTF_q_de,tfinal)
hold on
title('Step Response For 1 deg. \delta _e')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
% save2word('Plots_Bonus')

figure('units','normalized','outerposition',[0 0 1 1])
step(Full_Long_q_dT,ModelLinearizerTF_q_dT,tfinal)
hold on
title('Step Response For 1 deg. \delta _e')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
% save2word('Plots_Bonus')

figure('units','normalized','outerposition',[0 0 1 1])
step(Full_Long_theta_de,ModelLinearizerTF_theta_de,tfinal)
hold on
title('Step Response For 1 deg. \delta _e')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
% save2word('Plots_Bonus')

figure('units','normalized','outerposition',[0 0 1 1])
step(Full_Long_theta_dT,ModelLinearizerTF_theta_dT,tfinal)
hold on
title('Step Response For 1 deg. \delta _e')
set(findall(gcf,'type','line'),'linewidth',1.7);grid on ;legend ;
% save2word('Plots_Bonus')

