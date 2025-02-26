function states_dot = get_states_dot(t,states_vec)

F = [2;8;3] ;

M = [14;20;7] ;

I = [1,-2,-1;-2,5,-4;-1,-4,0.2];

m = 11;

u = states_vec(1);
v= states_vec(2);
w= states_vec(3);


p= states_vec(4);
q= states_vec(5);
r= states_vec(6);


phi= states_vec(7);
ceta= states_vec(8);
psi= states_vec(9);
eul = [psi ceta phi] ;

X= states_vec(10);
Y= states_vec(11);
Z= states_vec(12);


states_dot (1:3,1) = (1/m)*F-cross([p;q;r],[u;v;w]) ;

states_dot (4:6,1) = inv(I)*[M-cross([p;q;r],I*[p;q;r])] ;

states_dot (7:9,1) = [1, sin(phi)*tan(ceta), cos(phi)*tan(ceta) ; 0, cos(phi), -sin(phi) ; 0, sin(phi)/cos(ceta), cos(phi)/cos(ceta)] * [p;q;r];

states_dot (10:12,1) =  eul2rotm(eul,"ZYX")*[u;v;w];




states_dot = states_dot (1:12,1);

end