%%%%Problema Control Directo de Velocidad MCC-IP
% Parámetros del MCC 
% Mohan, Undeland, Robbins, Ch. 12. Introduction to Motor Drives, p. 396.

%close all
clear
clc
%Datos de MCC-IP
Tr=10; % torque nominal Nm
nr=3750; %velocidad nominal rpm
Kt=0.5; %Nm/A
Ke=53; %V/1000rpm
Ra=0.37; %Ohm
Te=4.05*10^-3; %ms
Tm=11.7*10^-3; %ms


%Calculo de parametros MCC-IP
La=Te*Ra;
KN=Kt;
wr=nr*2*pi/60;
Iar=Tr/KN;
J=(Tm*KN^2)/Ra;
Tc=0; %Torque de carga
Pr=Tr*wr; %Potencia mecanica nominal
Uar=Pr/Iar;

TM=J*Ra/(KN^2);
Ta=La/Ra;
%Se cumple que TM>2*Ta

% % % Ajuste del PI
Kpn= KN*(TM/(2*Ta)-1);
Tin=4*Ta*(1-2*Ta/(TM));

%%Escenario de simulacion
Tc=15; %Torque de carga
wref=392;
Td=0;

%%%Simulaciones con modelo del MCC
sim1=sim("model_Tp0a.slx");
figure(1)
hold on
plot(sim1.tout,sim1.w,sim1.tout,sim1.wref)
figure(2)
hold on
plot(sim1.tout,sim1.Ia)

%%%Simulaciones con modelo del MCC + CEP modelado como tiempo PT1
sim1=sim("model_Tp0b.slx");
figure(1)
hold on
plot(sim1.tout,sim1.w,sim1.tout,sim1.wref)
figure(2)
hold on
plot(sim1.tout,sim1.Ia)

%%%Simulaciones con modelo del MCC + CEP modelado como tiempo muerto
sim1=sim("model_Tp0c.slx");
figure(1)
hold on
plot(sim1.tout,sim1.w,sim1.tout,sim1.wref)
figure(2)
hold on
plot(sim1.tout,sim1.Ia)


%%%Simulaciones con modelo del MCC + CEP modelado como tiempo PT1 +
%%%sensor/filtro de velocidad
Tc=15; %Torque de carga
wref=392;
Td=0;
sim1=sim("model_Tp0bb.slx");
figure(1)
hold on
plot(sim1.tout,sim1.w,sim1.tout,sim1.wref)
figure(2)
hold on
plot(sim1.tout,sim1.Ia)

%%%Simulaciones con modelo del MCC + CEP modelado como tiempo muerto +
%%%sensor/filtro de velocidad
Tc=15; %Torque de carga
wref=392;
Td=0;
sim1=sim("model_Tp0cc.slx");
figure(1)
hold on
plot(sim1.tout,sim1.w,sim1.tout,sim1.wref)
figure(2)
hold on
plot(sim1.tout,sim1.Ia)



