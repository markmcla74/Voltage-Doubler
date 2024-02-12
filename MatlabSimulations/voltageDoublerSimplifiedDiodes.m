%NOTE!!
%Expected Max Voltage across C2 = 2Vmax - 0.65 -0.65 = 16.7 V
%If the output is greater than 16.7 V, then you need to make dt smaller

clear;
maxCurrent = 0.1; %100ma or 0.1A
tmin=0;
tmax=10; %10 cycles
vMax=9;
dt=1/800; %dt = 1 cycle / 800
t=tmin:dt:tmax;

ftemp=sin(2*pi*t);
f=vMax*sign(ftemp); %create square wave
[M,N]=size(f);
for i=1:N
  if (f(1,i)==0)
    f(1,i)=vMax; %just a small correction. Start each cycle at vMax, not 0
  endif;
end;

c1=0.01; %choose capacitor values to be approx 0.01 * Period
c2=0.01;

vc1=0; %initialize capacitors to be uncharged
vc2=0;

for i=1:N
  voutput(1,i)=0; %initialize output vector
  vinput(1,i)=f(1,i); %initialize input vector
end;

for i=1:N   %perform voltage doubler simulation
 if (vinput(1,i) >=0) 
    vd=vinput(1,i) - vc1 -vc2;
    if (vd >= 0.65)
      idiode =maxCurrent;
    else
      idiode = 0;
    endif;
    i1=idiode;
    i2=idiode;
    dvc1=i1*dt/c1;
    dvc2=i2*dt/c2;
    vc1=dvc1 + vc1;
    vc2=dvc2 + vc2;
  endif;
 if (vinput(1,i) < 0) 
    vd= -vinput(1,i) -(-vc1);
    if (vd >= 0.65)
      idiode =maxCurrent;
    else
      idiode = 0;
    endif;
    dvc1=-idiode*dt/c1; 
    vc1= dvc1+ vc1;
 endif;

voutput(1,i)=vc2;
end;

[S,T]=size(voutput);
voltageAcrossC2 = voutput(1,T) %last calculated output voltage
hold on;
plot(t,voutput);
plot(t,vinput);
 axis([tmin tmax,(-vMax -1) 2*vMax+1]);
 xlabel('cycle number')
 ylabel('Voltage')
 title("Voltage Doubler with Simplified Diode Model \n Input Signal is square wave +-9 V, \n Expected Max Voltage across C2 = 2Vmax - 0.65 -0.65 = 16.7 V")
 