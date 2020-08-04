%control 2
%datos
datos=[0.164 0.079 0.005; 
       0.149 0.254 0.255; 
       0.126 0.215 0.252; 
       0.509 0.302 0.267; 
       0.321 0.426 0.367; 
       0.577 0.565 0.291; 
       0.667 0.655 0.291; 
       0.704 0.741 0.470; 
       0.779 0.687 0.646; 
       0.886 1.070 0.717];
   
%promedio
mean=[0.4882 0.4994 0.3561];
%desviación
std=[0.26626558 0.28458011 0.19700937];
%covarianza dtos sin normalizar
%covsn= [0.078775 0.0775590 0.046353; 0.077559 0.089984 0.054693; 0.046353 0.054693 0.043125];
%normalizar datos

norma=(datos-mean)./std;
covn=((norma).'*norma)/9;


[vectorpropio valorpropio]=eig(covn);

x=vectorpropio(:,[3]);
y=vectorpropio(:,[2]);

P=[x y];

Y=norma*P;

figure
scatter(Y(:,1),Y(:,2))
title('PCA y Score Plot')
xlabel('Componente asociada al mayor valor propio')
ylabel('Componente asociada al segundo mayor valor propio')

m_diag=[3.03410 0;0 0.2320];


vector=0:0.01:2*pi;

n=10;
for i=1:1:n
   z(i,1)= norma(i,:)*P*inv(m_diag)*P.'*norma(i,:).';
end



figure
hold on
title('Curvas de Nivel')
xlabel('Distancia asociada a mayor valor propio')
ylabel('Distancia asociada a segundo mayor valor propio')
n=10;
for i = 1:1:n
    a = sqrt(3.0341*z(i)); 
    b = sqrt(0.2320*z(i)); 
    x_elip = a*cos(vector); 
    y_elip = b*sin(vector); 
    plot(x_elip,y_elip) 
    scatter(Y(:,1),Y(:,2)) 
end

vec_diag=[3.0341 0.2320];
%total de componentes, a, coef Fisher, nu para 95% y 99% y a y b para 99% y
%95%
n=10;
a=2;

F_95_no= 4.46; 
F_95_si=4.74; 
F_99_no= 8.02;
F_99_si=9.55; 

nu95_nt=a*(n^2-1)*F_95_no/(n*(n-a));
nu95_t = ((n-1)^2)*(a/(n-a-1))*F_95_si/(n*(1+(a*F_95_si)/(n-a-1)));
nu99_nt = a*(n^2 - 1)*F_99_no/(n*(n-a));
nu99_t = (n-1)^2*(a/(n-a-1))*F_99_si/(n*(1+(a*F_99_si)/(n-a-1)));

a_95 = sqrt((vec_diag(:,[1]))*nu95_nt);
a_99 = sqrt((vec_diag(:,[1]))*nu99_nt);
b_95 = sqrt((vec_diag(:,[2]))*nu95_nt);
b_99 = sqrt((vec_diag(:,[2]))*nu99_nt);


%parametrización para 95%
vector_x95=a_95*cos(vector);
vector_y95=b_95*sin(vector);
%parametrización para 99%
vector_x99=a_99*cos(vector);
vector_y99=b_99*sin(vector);
%graficar
figure
hold on
scatter(Y(:,1),Y(:,2))
plot(vector_x95,vector_y95)
plot(vector_x99,vector_y99)
title("Test de Hotelling datos no están en training set")
xlabel("Proyección primera componente")
ylabel("Proyección segunda componente")
legend('PCA','umbral 95%','umbral 99%')

a_95_t = sqrt((vec_diag(:,[1]))*nu95_t);
a_99_t = sqrt((vec_diag(:,[1]))*nu99_t);
b_95_t = sqrt((vec_diag(:,[2]))*nu95_t);
b_99_t = sqrt((vec_diag(:,[2]))*nu99_t);

%parametrización para 95%
vector_x95_t=a_95_t*cos(vector);
vector_y95_t=b_95_t*sin(vector);
%parametrización para 99%
vector_x99_t=a_99_t*cos(vector);
vector_y99_t=b_99_t*sin(vector);

figure
hold on
scatter(Y(:,1),Y(:,2))
plot(vector_x95_t,vector_y95_t)
plot(vector_x99_t,vector_y99_t)
title("Test de Hotelling datos si están en training set")
xlabel("Proyección primera componente")
ylabel("Proyección segunda componente")
legend('PCA','umbral 95%','umbral 99%')
