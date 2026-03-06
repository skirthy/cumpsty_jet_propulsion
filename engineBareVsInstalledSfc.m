# ==============================================================================
# COMPARE SFC FOR BARE VS INSTALLED ENGINE
# ------------------------------------------------------------------------------
# Nicholas Cumpsty, Jet propulsion (2005), Cambridge University Press.
# Page 75, Exercise 7.2(a).
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 06/03/2026
# ==============================================================================

clear all
close all
clc

engineData    = importdata('enginePropValues_vs_bypassRatio.dat');

engineBypRatio        = engineData(:,64);
engineSfcBare         = engineData(:,73);

engineSfcInstalled    = (1.04+0.01*(engineBypRatio-1)).*engineSfcBare;

figure(1)
grid on
hold on
[hax, h1, h2] = plotyy(engineBypRatio,engineSfcBare,engineBypRatio,engineSfcInstalled)
set(hax,'Fontsize',20)
set([h1],'Linewidth',2)
set([h2],'Linewidth',2)
ylim(hax(1),[0.4 0.9])
ylim(hax(2),[0.4 0.9])
xlabel('Bypass ratio','Fontsize',24)
ylabel(hax(1),'Bare sfc (kg/s/kg-f)','Fontsize',24)
ylabel(hax(2),'Installed sfc (kg/s/kg-f)','Fontsize',24)
