# ==============================================================================
# GIVEN:
# 1. NET THRUST (AT CRUISE CLIMB)
# 2. ENGINE PROPERTIES
# CALCULATE:
# 1. MASS FLOW RATE OF AIR (CORE AND BYPASS)
# 2. GROSS THRUST
# ------------------------------------------------------------------------------
# Nicholas Cumpsty, Jet propulsion (2005), Cambridge University Press.
# Page 75, Exercise 7.2(b).
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 06/03/2026
# ==============================================================================

clear all
close all
clc

engineData    = importdata('enginePropValues_vs_bypassRatio.dat');

engineNetThrust           = 75.1;   # Net thrust (kN)

engineBypRatio            = engineData(:,64);
engineGrossThrustSpec     = engineData(:,68);
engineNetThrustSpec       = engineData(:,69);

engineMdotAirCore         = (engineNetThrust)./engineNetThrustSpec;

engineGrossThrust         = (engineMdotAirCore).*engineGrossThrustSpec;

engineMdotAir             = (1+engineBypRatio).*engineMdotAirCore;

figure(1)
grid on
hold on
[hax, h1, h2] = plotyy(engineBypRatio,engineGrossThrust,engineBypRatio,engineNetThrust*(ones(length(engineBypRatio))))
set(hax,'Fontsize',20)
set([h1],'Linewidth',2)
set([h2],'Linewidth',2)
xlabel('Bypass ratio','Fontsize',24)
ylabel(hax(1),'Gross thrust (kN)','Fontsize',24)
ylabel(hax(2),'Net thrust (kN)','Fontsize',24)

figure(2)
grid on
hold on
plot(engineBypRatio,engineMdotAir,'Linewidth',2)
set(gca,'Fontsize',20)
xlabel('Bypass ratio','Fontsize',24)
ylabel('Air mass flow rate (kg/s)','Fontsize',24)


