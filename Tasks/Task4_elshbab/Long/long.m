%% full linear model


A = [Xu  Xw  -w0  -9.81*cos(theta0)  ;
                 Zu/(1-Zwd)   Zw/(1-Zwd)  (Zq+u0)/(1-Zwd)  (-9.81*sin(theta0))/(1-Zwd) ;
                 Mu+Mw*(Zu/(1-Zwd))  Mw+Mw*(Zw/(1-Zwd))  Mq+Mw*(Zq+u0)/(1-Zwd)  -Mw*(-9.81*sin(theta0))/(1-Zwd) ;
                 0 0 1 0 ;];
% delta_controls : [d_aileron d_rudder d_elevator d_thrust]

B = [Xde  Xdth ;
     Zde/(1-Zwd)  Zdth/(1-Zwd); 
     Mde+Mwd*(Zde/(1-Zwd))  Mdth+Mwd*(Zdth/(1-Zwd));
     0 0 ;];
C=eye(4,4);
D=zeros(4,2);
%% TF of full model

all_tf=tf(ss(A,B,C,D));


tf_ue=all_tf(1,1);
tf_uth=all_tf(1,2);
tf_we=all_tf(2,1);
tf_wth=all_tf(2,2);
tf_qe=all_tf(3,1);
tf_qth=all_tf(3,2);
tf_thetae=all_tf(4,1);
tf_thetath=all_tf(4,2);




%% long period 


A_long_period=[Xu+(w0*Zu)/(Zq+u0) -9.81*cos(theta0)-(w0*9.81*sin(theta0)/(Zq+u0));
    -Zu/(Zq+u0) (9.81*sin(theta0))/(Zq+u0) ;];

B_long_period=[Xde+(w0*Zde)/(Zq+u0) Xdth+(w0*Zdth)/(Zq+u0);
                 -Zde/(Zq+u0) -Zdth/(Zq+u0) ; ];

%% TF of long peroid 
long_peroid_TF=tf(ss(A_long_period,B_long_period,eye(2,2),zeros(2,2)));
tf_ue_long=long_peroid_TF(1,1);
tf_uth_long=long_peroid_TF(1,2);
tf_thetae_long=long_peroid_TF(2,1);
tf_thetath_long=long_peroid_TF(2,2);



%% short peroid 

A_short_period = [Zw/(1-Zwd), (Zq+u0)/(1-Zwd);
    Mw+Mwd*Zw/(1-Zwd), Mq+Mwd*(Zq+u0)/(1-Zwd)];
B_short_period = [Zde/(1-Zwd), Zdth/(1-Zwd);
    Mde+Mwd*Zde/(1-Zwd), Mdth+Mwd*Zdth/(1-Zwd)];
C_short = eye(2); D_short = zeros(2,2);

%% TF of short peroid
short_peroid_TF=tf(ss(A_short_period,B_short_period,eye(2,2),zeros(2,2)));

tf_we_short=short_peroid_TF(1,1);
tf_wth_short=short_peroid_TF(1,2);
tf_qe_short=short_peroid_TF(2,1);
tf_qth_short=short_peroid_TF(2,1);


%%
de= 0;
dth=10000;
 sim('Aircraft_Simulator');
t=full_long.Time;
%full long data
full_u= full_long.Data(:,1);
full_w= full_long.Data(:,2);
full_q= full_long.Data(:,3);
full_theta= full_long.Data(:,4);

%long peroid data

long_u=long_peroid.Data(:,1);
long_theta=long_peroid.Data(:,2);

%short peroid data

short_w=short_peroid.Data(:,1);
short_q=short_peroid.Data(:,2);

export2=1;
figure
plot(t,out_u.Data);
hold on
plot(t,full_u);
plot(t,long_u,'g--');
legend('non linear model','Full Linearized Model', 'Long Period Approx')
title('u')
if export2==1
    exportgraphics(gcf,'Response of u.emf','BackgroundColor','none','ContentType','image')
end
figure
plot(t,out_w.Data);
hold on
plot(t,full_w);
plot(t,short_w,'g--');
legend('non linear model','Full Linearized Model', 'short Period Approx')
title('w')
if export2==1
    exportgraphics(gcf,'Response of w.emf','BackgroundColor','none','ContentType','image')
end
figure
plot(t,out_q.Data);
hold on
plot(t,full_q);
plot(t,short_q,'g--');
legend('non linear model','Full Linearized Model', 'Long Period Approx')
title('q')
if export2==1
    exportgraphics(gcf,'Response of q.emf','BackgroundColor','none','ContentType','image')
end
figure
plot(t,out_theta.Data);
hold on
plot(t,full_theta);
plot(t,long_theta,'g--');
legend('non linear model','Full Linearized Model', 'Long Period Approx')
title('theta')
if export2==1
    exportgraphics(gcf,'Response of theta.emf','BackgroundColor','none','ContentType','image')
end