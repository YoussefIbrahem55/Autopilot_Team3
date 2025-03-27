clc; close all;
%% Longitudinal State Space:

% Linearized Model State Space 
A_Long_Full = [Xu                 Xw                 -s0(3)                     -g*cos(s0(8))            ;
     Zu/(1-Zwd)         Zw/(1-Zwd)         (Zq+s0(1))/(1-Zwd)         -g*sin(s0(8))/(1-Zwd)    ;
     Mu+Mwd*Zu/(1-Zwd)  Mw+Mwd*Zw/(1-Zwd)  Mq+Mwd*(Zq+s0(1))/(1-Zwd)  -Mwd*g*sin(s0(8))/(1-Zwd);
     0                  0                  1                          0                        ];

B_Long_Full = [Xde                 Xdth;
    Zde/(1-Zwd)          Zdth/(1-Zwd);
    Mde+Mwd*Zde/(1-Zwd)  Mdth+Mwd*Zdth/(1-Zwd);
    0                    0                     ];

C_Long_Full = eye(4);

D_Long_Full = zeros(size(B_Long_Full));

% Approximated short period Model State Space 

A_Short = [Zw/(1-Zwd)          (Zq+s0(1))/(1-Zwd) 
          (Mw+Zw*Mwd/(1-Zwd))  (Mq+Mwd*(Zq+s0(1))/(1-Zwd))]; 

     
B_Short = [Zde/(1-Zwd)         Zdth/(1-Zwd)  
           Mde+Mwd*Zde/(1-Zwd) Mdth+Mwd*Zdth/(1-Zwd)]; 
C_Short = eye(2); 
D_Short = zeros(size(B_Short));

Za=u0*Zw; Zad=u0*Zwd; Ma=u0*Mw; Mad=u0*Mwd; 
A_Short2=[Za/(u0-Zad)           (Zq+u0)/(u0-Zad)
          Ma+Mad*Za/(u0-Zad)    Mq+Mad*(Zq+u0)/(u0-Zad)]; 

B_Short2=[Zde/(u0-Zad)              Zdth/(u0-Zad)
          Mde+Mad*Zde/(u0-Zad)      Mdth+Mad*Zdth/(u0-Zad)];

% Approximated long period Model State Space 

A_Long = [Xu             -g*cos(s0(8)) 
          -Zu/(s0(1)+Zq)  g*sin(s0(8))/(s0(1)+Zq)]; 

B_Long = [Xde          Xdth 
          -Zde/(Zq+s0(1))  -Zdth/(Zq+s0(1))]; 

C_Long = eye(2); 
D_Long = zeros(size(B_Long));

