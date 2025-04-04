close all
export1=1;
% u with elevator
figure
bode(tf_ue)
hold on
bode(tf_ue_long, 'r--')  % Dashed red line for comparison
title('Bode Plot of u with Elevator')
legend('Full Linearized Model', 'Long Period Approx')
grid minor
if export1==1
    exportgraphics(gcf,'Bode_u_elev.emf','BackgroundColor','none','ContentType','image')
end

figure
subplot(1,2,1)
rlocus(tf_ue)
title('Root Locus: u with Elevator Full')

subplot(1,2,2)
rlocus(tf_ue_long)
title('Root Locus: u with Elevator Long')

if export1==1
    exportgraphics(gcf,'rlocus_u_elev.emf','BackgroundColor','none','ContentType','image')
end

% u with thrust
figure
bode(tf_uth)
hold on
bode(tf_uth_long, 'r--')  % Dashed red line for comparison
title('Bode Plot of u with thrust')
legend('Full Linearized Model', 'Long Period Approx')
grid minor
if export1==1
    exportgraphics(gcf,'Bode_u_thrust.emf','BackgroundColor','none','ContentType','image')
end

figure
subplot(1,2,1)
rlocus(tf_uth)
title('Root Locus: u with thrust Full')

subplot(1,2,2)
rlocus(tf_uth_long)
title('Root Locus: u with thrust Long')

if export1==1
    exportgraphics(gcf,'rlocus_u_thrust.emf','BackgroundColor','none','ContentType','image')
end

% w with elevator
figure
bode(tf_we)
hold on
bode(tf_we_short, 'r--')  % Dashed red line for comparison
title('Bode Plot of w with Elevator')
legend('Full Linearized Model', 'Long Period Approx')
grid minor
if export1==1
    exportgraphics(gcf,'Bode_w_elev.emf','BackgroundColor','none','ContentType','image')
end

figure
subplot(1,2,1)
rlocus(tf_we)
title('Root Locus: w with Elevator Full')

subplot(1,2,2)
rlocus(tf_we_short)
title('Root Locus: w with Elevator short')

if export1==1
    exportgraphics(gcf,'rlocus_w_elev.emf','BackgroundColor','none','ContentType','image')
end

% w with thrust
figure
bode(tf_wth)
hold on
bode(tf_wth_short, 'r--')  % Dashed red line for comparison
title('Bode Plot of w with thrust')
legend('Full Linearized Model', 'short Period Approx')
grid minor
if export1==1
    exportgraphics(gcf,'Bode_w_thrust.emf','BackgroundColor','none','ContentType','image')
end

figure
subplot(1,2,1)
rlocus(tf_wth)
title('Root Locus: w with thrust Full')

subplot(1,2,2)
rlocus(tf_wth_short)
title('Root Locus: w with thrust short')

if export1==1
    exportgraphics(gcf,'rlocus_w_thrust.emf','BackgroundColor','none','ContentType','image')
end
  
% q with elevator
figure
bode(tf_qe)
hold on
bode(tf_qe_short, 'r--')  % Dashed red line for comparison
title('Bode Plot of q with Elevator')
legend('Full Linearized Model', 'short Period Approx')
grid minor
if export1==1
    exportgraphics(gcf,'Bode_q_elev.emf','BackgroundColor','none','ContentType','image')
end

figure
subplot(1,2,1)
rlocus(tf_qe)
title('Root Locus: q with Elevator Full')

subplot(1,2,2)
rlocus(tf_qe_short)
title('Root Locus: q with Elevator short')

if export1==1
    exportgraphics(gcf,'rlocus_q_elev.emf','BackgroundColor','none','ContentType','image')
end

% q with thrust
figure
bode(tf_qth)
hold on
bode(tf_qth_short, 'r--')  % Dashed red line for comparison
title('Bode Plot of q with thrust')
legend('Full Linearized Model', 'short Period Approx')
grid minor
if export1==1
    exportgraphics(gcf,'Bode_q_thrust.emf','BackgroundColor','none','ContentType','image')
end

figure
subplot(1,2,1)
rlocus(tf_qth)
title('Root Locus: q with thrust Full')

subplot(1,2,2)
rlocus(tf_qth_short)
title('Root Locus: q with thrust short')

if export1==1
    exportgraphics(gcf,'rlocus_q_thrust.emf','BackgroundColor','none','ContentType','image')
end