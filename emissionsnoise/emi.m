%% CO2-eq Emissions
clc
g = 9.80665;                                % Gravity acceleration (m/s2)
%Inputs
Electric_mix = 190;							% CO2-eq emissions per kW.h of electric energy (gCO2eq/(kW.h))

HC=0;                                       % Hybridization factor in cruise (-)
Pc=260000+210000;                           % Power in cruise (W)
n_CS = 0.8;                                 % Power train efficiency of the combustion system (-)
Endurance = 720/(100*3.6);                  % Range(km)/(Vc(m/s)*3.6);   % Endurance (h)
Reserve = 5/3600;                        	% Reserve time (h)
Energy_fuel = (1-HC)*((Pc/n_CS)*(Endurance + Reserve)*1.06) % fuel energy (W.h)

MTOM=4000;
DL=(MTOM*g/(8*pi* 1.2^2));                  % disk loading (N/m2)
rho = 1.14549;                              % Air Density (kg/m3) - SL, ISA + 20ºC conditions 
Vtip=0.5*339.709;
Thr=(MTOM*g/8)
Phr = (MTOM*g/8)*(1.15*sqrt(DL/(2*rho)) + (rho*Vtip*Vtip*Vtip/DL)*(0.08*0.02/8)) %Thr*(ki*sqrt(DL/(2*rho)) + (rho*Vtip*Vtip*Vtip/DL)*(s*cd0/8))% Hover power per rotor (W)
Ph = 8*Phr;                                 %NR*Phr;     % Hover power (W)
n_ES = 0.9;                                 % Efficiency of the electric system
HoverTime = 15/60;                      	% Total hover time (h)
Ebat_r=0.3;
Energy_bat = ((Ph/n_ES)*HoverTime + HC*(Pc/n_ES)*(Endurance + Reserve))/(1 - Ebat_r)   % battery energy (W.h))

Fuel_emissions = 0.111;                     % CO2-eq emissions per MJ of fuel (gCO2eq/MJ)

N_cycles=500;

Battery_production = 147.7*1000;           % CO2-eq emissions per kW.h of battery produced (gCO2eq/(kW.h))
%Battery_production = 80.8*1000;           % CO2-eq emissions per kW.h of battery produced (gCO2eq/(kW.h))

Fuel_production= 30.4;                      % (gCO2eq/MJ)

%Emissions
Emissions_energy = ((Energy_bat/1000)*Electric_mix + (Energy_fuel*3.6/1000)*Fuel_emissions)*N_cycles/1000 % CO2-eq emissions due to energy consumption (kgCO2eq)

Emissions_production = ((Energy_bat/1000)*Battery_production + (Energy_fuel*3.6/1000)*Fuel_production*N_cycles)/1000  % CO2-eq emissions due to energy production (kgCO2eq)
Emissions_total = Emissions_energy + Emissions_production;        % Total value of CO2-eq emissions (kgCO2eq)

Emissions_fuel = ((Energy_fuel*3.6/1000)*Fuel_emissions + (Energy_fuel*3.6/1000)*Fuel_production)*N_cycles/1000  % CO2-eq emissions due to fuel energy consumption and production (kgCO2eq)
Emissions_battery = ((Energy_bat/1000)*Electric_mix*N_cycles + (Energy_bat/1000)*Battery_production)/1000        % CO2-eq emissions due to battery energy production and consumption (kgCO2eq)

