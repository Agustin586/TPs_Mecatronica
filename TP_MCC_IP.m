%% Inicializacion
clear all
close all
clc

%% Calculos previos para el motor
close all
clc

% Datos
P = 12.2e3; %KW
Ra = 0.153; %Ohm
wn = (3500/60) *2*pi;   %rad/s
La = 1.3e-3;    %mHy
J = 0.068;  %Kgm^2
k_flujo = 0.9;  %Vs/rad
b = 0;
Ua = 340;   %V

% Parametros a calcular
Ia = P/Ua;  %A
Ea = Ua - Ia*Ra;    %V
KN = Ea/wn;  %Vs/rad
Tem = KN*Ia;

Ta = La/Ra;
Tm=J*Ra/(KN^2+b*Ra);


if (Tm > 2*Ta)
    fprintf('Todo ok\n');
else
    fprintf('No se cumple condicion de respuesta maximamente plana\n');
end

%{
    Nota: No se está cumpliendo que Tm > 2Ta. Seguramente hay algun error
    al calcular la cte K.
%}

%% Simulacion 1ra etapa
Tc = 15; % Sin torque de carga
wref = wn;

% Ajuste del PI
Kpn= KN*(Tm/(2*Ta)-1);
Tin=4*Ta*(1-2*Ta/(Tm));

%%%Simulaciones con modelo del MCC
sim1=sim("model_Tp0a.slx");
figure(1)
hold on
plot(sim1.tout,sim1.w,sim1.tout,sim1.wref),grid on;
legend('w','w_{ref}')
figure(2)
hold on
plot(sim1.tout,sim1.Ia), grid on;
legend('I_a');



%%  Rozamiento distinto de cero
clc,close all

b = 9.0817*10^-4;   %Nms/rad

Ta = La/Ra;
Tm=J*Ra/(KN^2+b*Ra);


if (Tm > 2*Ta)
    fprintf('Todo ok\n');
else
    fprintf('No se cumple condicion de respuesta maximamente plana\n');
end

% Ajuste del PI
Kpn= KN*(Tm/(2*Ta)-1);
Tin=4*Ta*(1-2*Ta/(Tm));

%%%Simulaciones con modelo del MCC
sim1=sim("model_Tp0a.slx");
figure(1)
hold on
plot(sim1.tout,sim1.w,sim1.tout,sim1.wref),grid on;
legend('w','w_{ref}')
figure(2)
hold on
plot(sim1.tout,sim1.Ia),hold on, grid on;
%legend('I_a1');


%%  Ahora probamos el convertidor de potencia

clc, 

Kpr=10;
Tpr=1.67e-3;

%%%Simulaciones con modelo del MCC
sim1=sim("model_Tp0c.slx");
figure(1)
hold on
plot(sim1.tout,sim1.w,sim1.tout,sim1.wref),grid on;
legend('w','w_{ref}')
figure(2)
hold on
plot(sim1.tout,sim1.Ia), grid on;
legend('I_a1', 'I_a2');



%%  Control de Tracking
close all,clc;
%cttes del controlador
a1=(Ra/La)+(b/J);
a2=(Ra*b+KN^2)/(La*J);
b0=KN/(La*J);
c0=Ra/(La*J);
c1=1/J;

