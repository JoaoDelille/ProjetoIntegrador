function [SPL_max] = noise_estimation(m,NB,NR,r,s,t_c_max,Vtip,Phr,Thr,alt,rho,a) 
%% Noise estimation
   m=1 %- Harmonic number (-)
   NB=3 %- Number of blades (m) (usually between 2 and 5)
   NR=8 %- Number of rotors (-) (ASSUMPTION: ALL ROTORS ARE THE SAME)
   r=1.2 %- Radius of the rotor (m) %1.041124
   s=0.08 %- Solidity ratio of the rotor (-) (usually between 0.08 and 0.2)
   t_c_max=0.12 %- maximum thickness to chord ratio of the rotor's blade (-) (associated to the airfoil chosen, a typical value is 0.12)
   Vtip=0.4*339.709 %- velocity at the tip of the rotor (m/s)
   Phr=125000 %- hover power per rotor (W) 115 000 9.8104e+04
   Thr=5573.99069 %- thrust generated per rotor in hover (N) 4905 3677.5 4883.248296 
   alt=500*0.3048 %- altitude away from the observer (m) (usually for helicopters is an altitude of 500 ft)
   rho=1.20718 %- air density (kg/m3)
   a=339.709 %- speed of sound (m/s)

  c = pi()*r*s/NB;                    % (m) Blade's mean chord
  t = t_c_max*c;                      % (m) Blade's maximum thickness
  Omega = Vtip/r;                     % (rad/s)
  Torque = Phr*r/Vtip;                % (N.m)
  Cl = 6*Thr/(rho*Vtip*Vtip*NB*c*r);  % (-) mean lift coefficient
  pref = 2.0e-5;                      % (Pa) Reference pressure
  St = 0.28;                          % (-) Strouhal number
  nsteps = 50;
  for i=1:(nsteps+1)
    aa = 89 - (i-1)*80/nsteps;
    ydist(i) = alt/sin(aa*pi()/180);
    DS = ydist(i);
    tt(i) = (pi()/2) + aa*(pi()/180);
    theta = tt(i);

    %% Rotational Noise
    Re = 0.8*r;
    JmB = besselj(m*NB,(m*NB*Omega*Re*sin(theta)/a));
    pmL = (m*NB*Omega/(2*sqrt(2)*pi()*a*DS))*(Thr*cos(theta) - Torque*a/(Omega*Re*Re))*JmB;
    pmT = -(rho*((m*NB*Omega)^2)*NB/(3*sqrt(2)*pi()*DS))*c*t*Re*JmB;
    pd_rot = NR*((pmL*pmL + pmT*pmT)/(pref*pref));

    %% Vortex Noise
    AA = pi()*r*r; % Disk area
    % 1st Step - Find Peak Frequency and the Overall SPL
    alpha = Cl/(2*pi());
    hh = t*cos(alpha) + c*sin(alpha);
    fpeak = (0.7*Vtip)*St/hh;
    k2 = 1.206*10^-2;   % (s^3/ft^3) Calibrated for helicopter
    k2 = k2/(.3048^3);  % (s^3/m^3)
    SPLo = 20*log10(k2*(Vtip/(rho*DS))*sqrt(NR*Thr*(Thr/AA)/s));
    % 2nd Step - Calculate SPL for each of spectrum frequencies
    freq = [fpeak/2; fpeak; 2*fpeak; 4*fpeak; 8*fpeak; 16*fpeak];
    SPL_w = [7.92; 4.17; 8.33; 8.75; 12.92; 13.33];
    SPL_ctr = 0;
    for ii = 1:5
      fr1 = freq(ii)/fpeak;
      SPL1 = SPLo - SPL_w(ii);
      fr2 = freq(ii+1)/fpeak;
      SPL2 = SPLo - SPL_w(ii+1);
      C1 = (SPL2 - SPL1)/(log10(fr2) - log10(fr1));
      C2 = SPL2 - C1*log10(fr2);
      int_val = (10^(C2/10))*((fr2^(C1/10 + 1))/(C1/10 + 1)) - (10^(C2/10))*((fr1^(C1/10 + 1))/(C1/10 + 1));
      SPL_ctr = SPL_ctr + int_val;
    end
    pd_vortex = SPL_ctr;

    %% Total Noise
    SPL(i) = 10*log10(pd_rot + pd_vortex);
  end
  SPL_max = max(SPL);
