function bode_general(sys_trans,state,leg_vec)
figure 
temp = size(sys_trans);
length_m = temp(2);
colored = {'r','k','--g','-.m',':b'};
for i = 1:1:length_m
bode(sys_trans{i}, colored{i})
hold on     
end
lgd = legend(leg_vec);
lgd.Location = 'southoutside';
lgd.Orientation = 'horizontal';
titll = ['comparing between the bode plot of  ',state] ;% u due de 
title(titll);
hold off
end 