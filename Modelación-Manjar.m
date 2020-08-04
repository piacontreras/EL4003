%definiendo las variables
%medio 1 (agua)
A_olla = 0.75; %area de la olla [m**2] se calculó con el radio de la olla de 0.2 [m] y la altura de la olla de 0.4[m]
ro = 997; %densidad del agua [kg/m**3]
c_1 = 4181; %calor específico del agua [J/Kg*K]
V = 0.05; %volumen de la olla [m**3]
%medio ambiente
T_a= 298.15; %temperatura ambiente [K], equivale a 25°C
%medio 2 (lata de manjar)
h = 209; %coef de transferencia de calor [W/m**2*K]
m = 0.12; %masa de la lata de manjar [Kg]
c_2 = 880; %calor específico del manjar [J/Kg*K]
A_lata = 0.24; %area de la lata de manjar [m**2] calculada con la fórmula del cilindro de radio 0.03 [m] y altura 0.1 [m]
V_lata = 0.00028; %[m**3] calculada con la fórmula de volumen para cilindro
%medio 3 (manjar)
A_manjar = 0.24; %suponemos que la lata de manjar está llena de manjar
ro_manjar = 1032; %densidad del manjar [Kg/m**3]
Man = 0.29; % masa manjar calculada como ro_manjar*V_lata [Kg]
c_3 = 3500; %calor especifico manjar [J/Kg*K]

%llevandolo a matriz
s1 = 1/ (ro*c_1*V);
s2 = (h*A_olla)/(ro*c_1*V);
s3 = (h*A_lata)/(ro*c_1*V);
s4 = (h*A_lata)/(m*c_2);
s5 = (h*A_lata)/(m*c_2);
s6 = (h*A_lata)/(Man*c_3);

A=[-s2-s3, s3, 0; s4, -s4-s5, s5; 0, s6, -s6];
B=[s1; 0; 0];
D=[T_a*s2;0;0];

x0=[298.15,298.15,298.15]; %condiciones iniciales 25°C
u=241874; %entrada de Q(t)

%Grafico
temperatura=simout;
t=tout;

plot(t,temperatura)
xlabel 'Tiempo [seg]';
ylabel 'Temperatura [K]';
grid;
title ('Temperatura de distintos medios en el tiempo')
legend ('Temperatura agua T_1','Temperatura lata T_2','Temperatura manjar T_3')

