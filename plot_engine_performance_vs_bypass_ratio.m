# ------------------------------------------------------------------------------
# ENGINE PERFORMANCE (SAME JET SPEEDS IN CORE AND BYPASS STREAMS)
# AS A FUNCTION OF BYPASS RATIO
#
# Nicholas Cumpsty, Jet propulsion (2005), Cambridge University Press.
# Page 73, Exercise 7.1.
#-------------------------------------------------------------------------------

clear all
close all
clc

machNo    = 0.85;
gasConst  = 287;
gammaAir  = 1.4;          # Ratio of specific heat capacities (Cp/Cv)
##cpAir     = 1005;

temp2     = 226.7;        # Static temperature at H = 31000 ft (K)

##temp02    = temp2*(1+((gammaAir-1)/2)*(machNo^2));        # Stagnation temperature at the fan entry (at H = 31000 ft, M = 0.85) (K)
##temp04    = 1450;         # Turbine inlet temperature (Temperature at the combustor exit) (K)
##
##pres2     = 28.7;         # Static pressure at H = 31000 ft (kPa)
##pres02    = 46;           # Stagnation pressure at the fan entry (kPa)
##
##presRatio023to02  = 1.6;  # Pressure ratio across the fan in the core stream
##presRatio013to02  = 1.0;  # Pressure ratio across the fan in the bypass stream
##presRatio03to023  = 25;   # Pressure ratio across the core compressor
##
##effFan            = 0.9;  # Fan isentropic efficiency
##effComp           = 0.9;  # Compressor isentropic efficiency
##effTurb           = 0.9;  # Turbine isentropic efficiency
##effNozzle         = 1.0;  # Nozzle isentropic efficiency

# Aircraft speed
velAircraft       = machNo*sqrt(gammaAir*gasConst*temp2);

bypRatioData  = importdata('engine_performance_vs_bypass_ratio.dat')

bypRatio      = bypRatioData(:,1);
velJet        = bypRatioData(:,2);
tempBypJet    = bypRatioData(:,3);
tempCoreJet   = bypRatioData(:,4);
tempDiffLPT   = bypRatioData(:,5);
presRatioLPT  = bypRatioData(:,6);
presRatioFan  = bypRatioData(:,7);

effProp       = 2*velAircraft./(velJet+velAircraft);

figure(1)
grid on
hold on
[hax, h1, h2] = plotyy(bypRatio,velJet,bypRatio,effProp)
set(hax,'Fontsize',20)
set([h1],'Linewidth',2)
set([h2],'Linewidth',2)
xlabel('Bypass ratio','Fontsize',24)
ylabel(hax(1),'Jet velocity (m/s)','Fontsize',24)
ylabel(hax(2),'Propulsive efficiency','Fontsize',24)

##figure(2)
##grid on
##hold on
##set(gca,'Fontsize',20)
##plot(bypRatio,effProp,'k.-','Markersize',15,'Linewidth',2)
##xlabel('Bypass ratio','Fontsize',24)
##ylabel('Propulsive efficiency','Fontsize',24)

figure(3)
grid on
hold on
set(gca,'Fontsize',20)
plot(bypRatio,tempBypJet,'b.-','Markersize',15,'Linewidth',2)
plot(bypRatio,tempCoreJet,'r.-','Markersize',15,'Linewidth',2)
plot(bypRatio,tempDiffLPT,'k.-','Markersize',15,'Linewidth',2)
xlabel('Bypass ratio','Fontsize',24)
ylabel('Jet temperature (K)','Fontsize',24)
legend('Bypass jet','Core jet','LPT temperature drop')

figure(4)
grid on
hold on
set(gca,'Fontsize',20)
plot(bypRatio,presRatioFan,'b.-','Markersize',15,'Linewidth',2)
plot(bypRatio,presRatioLPT,'r.-','Markersize',15,'Linewidth',2)
xlabel('Bypass ratio','Fontsize',24)
ylabel('Pressure ratio','Fontsize',24)
legend('Fan','LP turbine')
