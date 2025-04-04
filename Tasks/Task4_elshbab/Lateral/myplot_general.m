function myplot_general(y,t,xlab,ylab,titlle,leg_arr)
figure 
temp = size(y);
length_m = temp(2);
colored = ['r','k','b',"--g","-.m",":y"];
 for i = 1:1:length_m
   plot(t{i},y{i},colored(i))   
    hold on 
 end
lgd = legend(leg_arr);
lgd.Location = 'southoutside';
lgd.Orientation = 'horizontal';
xlabel(xlab)  %name (unit)
ylabel(ylab)  %name (unit)
title (titlle)
hold off 
end 