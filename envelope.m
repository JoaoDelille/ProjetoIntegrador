Mtom = 3621.2;
Clmax = 1.7;
rho = 0.9569;
V_C = 100;
S = 56; % aproximação para tandem wing usada no json
lift_slope = 5.4557;
chord = 2;
n_max = 2.1 + (24000/(10000 + Mtom*9.81)); %
n_min = -1; %

V_A = sqrt(2*n_max*Mtom*9.81/S/rho/Clmax)
V_G = sqrt(2*abs(n_min)*Mtom*9.81/S/rho/Clmax)
V_D = 1.5*V_C

V = 0:0.1:V_A;
parab1 = 0.5*rho*S*Clmax*V.^2/Mtom/9.81;
V2 = 0:0.1:V_G;
parab2 = -0.5*rho*S*Clmax*V2.^2/Mtom/9.81;
V3 = V_A:0.1:V_D;
cte1 = 0*V3 + n_max;
V4 = V_G:0.1:V_C;
cte2 = 0*V4 + n_min;
N = 0:0.1:n_max;
VD = 0*N + V_D;
V5 = V_C:0.1:V_D;
reta = -(n_min/(V_D-V_C))*(V5-V_C) + n_min;

mass_ratio = 2*Mtom/S/rho/chord/lift_slope;
k = 0.88*mass_ratio/(5.3+mass_ratio);

Ua = k*66*0.3048;
Uc = k*50*0.3048;
Ud = k*25*0.3048;

deltan1 = 1 + 0.5*rho*Ua*V*lift_slope*S/Mtom/9.81;
deltan11 = 1 - 0.5*rho*Ua*V*lift_slope*S/Mtom/9.81;
VV = 0:0.1:V_C;
deltan2 = 1 + 0.5*rho*Uc*VV*lift_slope*S/Mtom/9.81;
deltan22 = 1 - 0.5*rho*Uc*VV*lift_slope*S/Mtom/9.81;
VVV = 0:0.1:V_D;
deltan3 = 1 + 0.5*rho*Ud*VVV*lift_slope*S/Mtom/9.81;
deltan33 = 1 - 0.5*rho*Ud*VVV*lift_slope*S/Mtom/9.81;

figure()
plot(V,parab1,'blue',V2,parab2,'blue',V3,cte1,'blue',V4,cte2,'blue',VD,N,'blue',V5,reta,'blue')
grid
xlim([0 160])
xlabel('V (m/s)')
ylim([-1.5 3.5])
ylabel('n, fator de carga')
title('Flight envelope (without gust)')

figure()
plot(V,parab1,'blue',V2,parab2,'blue',V3,cte1,'blue',V4,cte2,'blue',VD,N,'blue',V5,reta,'blue',V,deltan1,'red',V,deltan11,'red',VV,deltan2,'red',VV,deltan22,'red',VVV,deltan3,'red',VVV,deltan33,'red')
grid
xlim([0 160])
xlabel('V (m/s)')
ylabel('n, fator de carga')
title('Flight envelope (with gust)')
