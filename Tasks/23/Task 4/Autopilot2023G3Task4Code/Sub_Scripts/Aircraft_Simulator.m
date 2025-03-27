%% close plots 
clc;close all;

%% RK4 Algorithm Solver

States(:,1) = s0;

    for i = 1:lengths
        if i == 1
         w_dot = w_dot0;
        end
        [F, M] = Airframe_Model(SD_Long_final,SD_Lat_final,[s0;w_dot0],[States(:,i);w_dot],m,I,dc);
        K_1 = RBD_Model(time_V(i)      , States(:,i),F,M,I,m);
        K_2 = RBD_Model(time_V(i)+dt/2 , States(:,i)+dt*K_1/2,F,M,I,m);
        K_3 = RBD_Model(time_V(i)+dt/2 , States(:,i)+dt*K_2/2,F,M,I,m);
        K_4 = RBD_Model(time_V(i)+dt   , States(:,i)+dt*K_3,F,M,I,m);

        States(:,i+1) = States(:,i) + (dt/6)*(K_1+2*K_2+2*K_3+K_4);
        w_dot = K_1(3);
    end

    States=States(:,1:lengths);

 %% State Arrangement

u = States(1,:);
v = States(2,:);
w = States(3,:);
p_deg = States(4,:)*180/pi;
q_deg = States(5,:)*180/pi;
r_deg = States(6,:)*180/pi;
phi_deg = States(7,:)*180/pi;
theta_deg = States(8,:)*180/pi;
psi_deg = States(9,:)*180/pi;
alpha_deg = atan(w./u)*180/pi;
beta_deg = asin(v./sqrt(u.^2+v.^2+w.^2))*180/pi;
x = States(10,:);
y = States(11,:);
z = States(12,:);

