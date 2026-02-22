clear all
close all
clc

gamma     = 1.4;                  # Ratio of specific heat capacities (gamma = cp/cv)

tempRatio = [3:8]';               # T4/T2
presRatio = [1:0.001:150]';       # Compression ratio
effComp   = 1;                    # Compressor isentropic efficiency
effTurb   = 1;                    # Turbine isentropic efficiency

presFac   = presRatio.^((gamma-1)/gamma);

workComp  = zeros(length(presRatio),length(tempRatio)); # Initializing the vector entries as zeroes
workTurb  = workComp;   # Initializing the vector entries as zeroes
workNet   = workComp;   # Initializing the vector entries as zeroes

maxPresRatio  = zeros(length(tempRatio),1);
optPresRatio  = maxPresRatio;
##maxWorkNet  = maxPresRatio;

plotTextFac   = 0.8;

for i=1:length(tempRatio)

  workTurb(:,i) = effTurb*(tempRatio(i)*(1-1./presFac));

  workComp(:,i) = (1/effComp)*(presFac-1);

  workNet(:,i) = workTurb(:,i)-workComp(:,i);

  [val1, col1] = min(abs(workNet(10:end,i)));
  [val2, col2] = max(workNet(:,i));

  maxPresRatio(i,1) = presRatio(col1);    # Pressure ratio at which net work is zero
##  maxWorkNet(i,1) = val2;
  optPresRatio(i,1) = presRatio(col2);    # Pressure ratio at which net work is maximum

  figure(1)

  grid on
  hold on
  set(gca,'Fontsize',16)

  plot(presRatio,workNet(:,i),'b-')
  text(presRatio(round(plotTextFac*length(presRatio))),workNet((round(plotTextFac*length(presRatio))),i),
      strcat('T4/T2 = ',num2str(tempRatio(i))),'Fontsize',16)
  xlabel('Pressure ratio','Fontsize',16)
  ylabel('Normalized net work','Fontsize',16)

  figure(1)

  grid on
  hold on
  set(gca,'Fontsize',16)

  plot(presRatio,workNet(:,i),'k-')
  text(presRatio(round(plotTextFac*length(presRatio))),workNet((round(plotTextFac*length(presRatio))),i),
      strcat('T4/T2 = ',num2str(tempRatio(i))),'Fontsize',16)
  xlabel('Pressure ratio','Fontsize',16)
  ylabel('Normalized net work','Fontsize',16)

  figure(2)

  grid on
  hold on
  set(gca,'Fontsize',16)

  plot(presRatio,workComp(:,i),'b-')
  plot(presRatio,workTurb(:,i),'r-')
  text(presRatio(round(plotTextFac*length(presRatio))),workTurb((round(plotTextFac*length(presRatio))),i),
      strcat('T4/T2 = ',num2str(tempRatio(i))),'Fontsize',16)
  xlabel('Pressure ratio','Fontsize',16)
  ylabel('Normalized work - compressor and turbine','Fontsize',16)

end

##  figure(3)
##
##  grid on
##  hold on
##  set(gca,'Fontsize',16)
##
##  plot(tempRatio,maxPresRatio,'r-')
##  xlabel('Temperature ratio','Fontsize',16)
##  ylabel('Maximum pressure ratio possible','Fontsize',16)

  figure(4)

  grid on
  hold on
  set(gca,'Fontsize',16)

  plot(tempRatio,optPresRatio,'k.-')
  xlabel('Temperature ratio','Fontsize',16)
  ylabel('Pressure ratio for maximum net work','Fontsize',16)
