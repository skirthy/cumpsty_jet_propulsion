clear all
close all
clc

presRatioComp = [1:30]';
##presRatioComp = 25;
##temp2 = 300.9;
##temp3 = 805.2;
##temp4 = 1450;
##temp5 = temp4-(temp3-temp2);
tempRatio = [3:7]';
effComp = 0.9;
effTurb = 0.9;

gamma = 1.4;

presFacComp = presRatioComp.^((gamma-1)/gamma);

##presFacTurb = (1-(1/effTurb)*(1-(1/(tempRatio*effComp))*(presFacComp-1))).^(-gamma/(gamma-1))
##presFacTurb = (1-(1/effTurb)*(1-(temp5/temp4))).^(-gamma/(gamma-1))

plotTextFac = 0.8;

for i=1:length(tempRatio)

  presRatioTurb = (1-(1/effTurb)*((1/tempRatio(i))*((presFacComp-1)/effComp))).^(-gamma/(gamma-1));

  figure(1)

  grid on
  hold on
  set(gca,'Fontsize',16)

  plot(presRatioComp,presRatioTurb,'b-')
  text(presRatioComp(round(plotTextFac*length(presRatioComp))),presRatioTurb(round(plotTextFac*length(presRatioTurb))),
      strcat('T4/T2 = ',num2str(tempRatio(i))),'Fontsize',16)
  xlabel('Compressor pressure ratio','Fontsize',16)
  ylabel('Turbine pressure ratio','Fontsize',16)

end



