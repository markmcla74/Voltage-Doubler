cycle = 1:1:10;
[M,N]=size(cycle);
Vmax = 5;
Vcycle(1) = Vmax/2
VcyclePrevious = Vcycle(1);

for i=2:N
  Vcycle(i)= Vmax + VcyclePrevious/2
  VcyclePrevious = Vcycle(i);
end;
 
 
 dt=0:0.05:1;
 [O,P]=size(dt);
 dtCycleColumnCount = 1;
 for i= 1:N
    for j=1:P
      dtCycle(1,dtCycleColumnCount)=dt(1,j) + (i-1);
      dtVcycle(1,dtCycleColumnCount)=Vcycle(i);
      dtCycleColumnCount = dtCycleColumnCount + 1;
    end;
 end;
 
 [Q,R]=size(dtCycle);
 [S,T]=size(dtVcycle);
 hold on;
 plot(dtCycle,dtVcycle,'-')
 xticks(0:N);
 axis([0 N,0 2*Vmax]);
 xlabel('cycle number')
 ylabel('Voltage')
 title('Ideal Voltage Doubler, Input Signal is square wave +-5 V, Output is Voltage across C2')