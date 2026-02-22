# ---------------------------------------------------------------------------------------
# BRAYTON CYCLE THERMAL EFFICIENCY VS PRESSURE RATIO AT A GIVEN TURBINE INLET TEMPERATURE

# Nicholas Cumpsty, Jet propulsion (2005), Cambridge University Press.
# Page 38, Exercise 4.3.
#----------------------------------------------------------------------------------------

clear all
close all
clc

temp2     = 259.5;      # Air entry temperature to the compressor - T2 (K)
temp4     = 1450;       # Turbine inlet temperature - T4 (K)
presRatio = [10:80]';   # Compressor/Turbine pressure ratio
effComp   = 0.9;        # Compressor isentropic efficiency
effTurb   = 0.9;        # Turbine isentropic efficiency

gamma     = 1.4;        # Ratio of specific heat capacities (gamma = cp/cv)
cpAir     = 1.005;      # Specific heat capacity of air at constant pressure (kJ/kg-K)

presFac   = presRatio.^((gamma-1)/gamma);   # To simplify the expression for cycle efficiency and net work

# Cycle/thermal efficiency
effCycle  = (effTurb*(temp4/temp2)*(1-1./presFac)-(presFac-1)/effComp)./((temp4/temp2)-(1+(presFac-1)/0.9));

# Net work (kJ/kg) = Turbine work - Compressor work
workNet   = (cpAir*temp2)*(effTurb*(temp4/temp2)*(1-1./presFac)-(presFac-1)/effComp);

# Thermal efficiency assuming 100% efficiency for compressor and turbine
effCycleIdeal = (1-1./presFac);

figure(1)

grid on
hold on
set(gca,'Fontsize',16)

plot(presRatio,effCycle,'b-')
plot(presRatio,effCycleIdeal,'k-')
xlabel('Pressure ratio','Fontsize',16)
ylabel('Cycle efficiency','Fontsize',16)

figure(2)

grid on
hold on
set(gca,'Fontsize',16)

plot(presRatio,workNet,'r-')
xlabel('Pressure ratio','Fontsize',16)
ylabel('Net work (kJ/kg)','Fontsize',16)
