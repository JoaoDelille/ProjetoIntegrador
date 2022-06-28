%% CO2-eq Emissions
clc
g = 9.80665;                                % Gravity acceleration (m/s2)
%----Inputs----
Electric_mix = 190;							% CO2-eq emissions per kW.h of electric energy (gCO2eq/(kW.h))
Fuel_emissions = 0.0635                     % CO2-eq emissions per MJ of fuel (gCO2eq/MJ)8.887/142.2;

MTOM=4548.11094;
DL=(MTOM*g/(8*pi* 1.2^2));                  % disk loading (N/m2)
rho = 1.14549;                              % Air Density (kg/m3) - SL, ISA + 20ºC conditions 
Vtip=0.4*339.709;
Thr=(MTOM*g/8)
Phr = (MTOM*g/8)*(1.15*sqrt(DL/(2*rho)) + (rho*Vtip*Vtip*Vtip/DL)*(0.08*0.02/8)) %Thr*(ki*sqrt(DL/(2*rho)) + (rho*Vtip*Vtip*Vtip/DL)*(s*cd0/8))% Hover power per rotor (W)
Ph = 8*Phr;                                 %NR*Phr;     % Hover power (W)
n_ES = 0.9;                                 % Efficiency of the electric system
HoverTime = 15/60;                      	% Total hover time (h)
HC=260000/(260000+210000);                  % Hybridization factor in cruise (-)
Endurance = 720/(100*3.6);                  % Range(km)/(Vc(m/s)*3.6);   % Endurance (h)
Reserve = 5/3600;                        	% Reserve time (h)
Ebat_r=0.2;                                 % batteries reserve (-)

%--Emissions_energy--
Energy_bat = ((Ph/n_ES)*HoverTime + HC*(Pc/n_ES)*(Endurance + Reserve))/(1 - Ebat_r);   % battery energy (W.h))

%----Calc----
Emissions_energy = ((Energy_bat/1000)*Electric_mix + (Energy_fuel*3.6/1000)*Fuel_emissions)*N_cycles/1000; % CO2-eq emissions due to energy consumption (kgCO2eq)
Battery_production = 80.8*1000;									% CO2-eq emissions per kW.h of battery produced (gCO2eq/(kW.h))
Emissions_production = ((Energy_bat/1000)*Battery_production + (Energy_fuel*3.6/1000)*Fuel_production*N_cycles)/1000;  % CO2-eq emissions due to energy production (kgCO2eq)
Emissions_total = Emissions_energy + Emissions_production;        % Total value of CO2-eq emissions (kgCO2eq)

Emissions_fuel = ((Energy_fuel*3.6/1000)*Fuel_emissions + (Energy_fuel*3.6/1000)*Fuel_production)*N_cycles/1000;  % CO2-eq emissions due to fuel energy consumption and production (kgCO2eq)
Emissions_battery = ((Energy_bat/1000)*Electric_mix*N_cycles + (Energy_bat/1000)*Battery_production)/1000;        % CO2-eq emissions due to battery energy production and consumption (kgCO2eq)



Pc=260000+210000;                           % Power in cruise (W)
n_CS = 0.8;                                 % Power train efficiency of the combustion system (-)


Energy_fuel = (1-HC)*((Pc/n_CS)*(Endurance + Reserve)*1.05); % fuel energy (W.h)






Energy_bat = ((Ph/n_ES)*HoverTime + HC*(Pc/n_ES)*(Endurance + Reserve))/(1 - Ebat_r);   % battery energy (W.h))


N_cycles=500;

Battery_production = 147.7*1000;            % CO2-eq emissions per kW.h of battery produced (gCO2eq/(kW.h))

Fuel_production= 30.4;                      % (gCO2eq/MJ)

%Emissions
Emissions_energy = ((Energy_bat/1000)*Electric_mix + (Energy_fuel*3.6/1000)*Fuel_emissions)*N_cycles/1000; % CO2-eq emissions due to energy consumption (kgCO2eq)

Emissions_production = ((Energy_bat/1000)*Battery_production + (Energy_fuel*3.6/1000)*Fuel_production*N_cycles)/1000;  % CO2-eq emissions due to energy production (kgCO2eq)
Emissions_total = Emissions_energy + Emissions_production;        % Total value of CO2-eq emissions (kgCO2eq)

Emissions_fuel = ((Energy_fuel*3.6/1000)*Fuel_emissions + (Energy_fuel*3.6/1000)*Fuel_production)*N_cycles/1000  % CO2-eq emissions due to fuel energy consumption and production (kgCO2eq)
Emissions_battery = ((Energy_bat/1000)*Electric_mix*N_cycles + (Energy_bat/1000)*Battery_production)/1000        % CO2-eq emissions due to battery energy production and consumption (kgCO2eq)
