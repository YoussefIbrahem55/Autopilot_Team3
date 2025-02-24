function [t_vec,y] = RK4(states_dot,t_vec,y0)

n = length(t_vec);
y(:,1) = y0  ;
dt = t_vec(2) -t_vec(1) ;

for i = 1:n

    k1 = states_dot(t_vec(i),y(:,i)) ;
    k2 = states_dot(t_vec(i)+dt/2,y(:,i)+k1*dt/2) ;
    k3 = states_dot(t_vec(i)+dt/2,y(:,i)+k2*dt/2) ;
    k4 = states_dot(t_vec(i)+dt,y(:,i)+k3*dt) ;

    y(:,i+1) = y(:,i) + (dt/6)*(k1+2*k2+2*k3+k4) ;
end

y = y(:,1:n);