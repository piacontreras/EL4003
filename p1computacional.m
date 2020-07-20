%P1-1
%se debe cargar en el workspace el archivo P2_data
%rellenamos los nan con la mediana de la matriz
xFill = fillmissing(X,'linear',2,'EndValues','nearest');
%sacando el promedio de la matriz
prom=mean(xFill);
%desviación estandar de la matriz
desv=std(xFill);
%normalizando los datos de la matriz
norm=(xFill-prom)./desv;
%matriz de varianza covarianza empírica
cov=((norm).'*(norm))/(205-1);
%calculando vectores y valores propios
[vectores, valores]=eig(cov);
%los dos ultimos vectores de la matriz vectores son los vectores propios
%asociados a los mayores valores propios
x=vectores(:,[26]);
y=vectores(:,[25]);
%construcción matriz Proyección
P=[x y];
%construcción matriz Y
Y=norm*P;
%obtenemos el eje de las abscisas y el eje de las ordenadas
x1=Y(:,1);
y1=Y(:,2);
%graficar
figure
scatter(x1,y1)
title('PCA y Score Plot')
xlabel('Componente asociada al mayor valor propio')
ylabel('Componente asociada al segundo mayor valor propio')

%P1-2
%matriz diagonal con los dos mayores valores propios
m_diag=[8.0970 0;0 4.3890];
%recorriedo parametrización
vector=0:0.01:2*pi;
%obteniendo forma cuadrática
n=205;
for i=1:1:n
   z(i,1)= norm(i,:)*P*inv(m_diag)*P'*norm(i,:)'; 
end
%para cada fila en el vector z habrá un valor distinto para a y para b, por
%lo tanto en un ciclo se recorren un obtienen los valores para a y para b,
%luego se parametriza la elipse y se grafica
figure
hold on
title('Curvas de Nivel')
xlabel('Distancia asociada a mayor valor propio')
ylabel('Distancia asociada a segundo mayor valor propio')
for i = 1:1:n
    a = sqrt(8.0970*z(i)); 
    b = sqrt(4.3890*z(i)); 
    x_elip = a*cos(vector); 
    y_elip = b*sin(vector); 
    plot(x_elip,y_elip) 
    %scatter(x1,y1) 
end
%se puede observar que para cada punto existe una elipse de control

%P1-2-B
%vector con los dos mayores valores propios
vec_diag=[8.0970 4.3890];
%total de componentes, a, coef Fisher, nu para 95% y 99% y a y b para 99% y
%95%
n=205;
a=2;
F_95_2=3.041;
F_95_1=3.888;
F_99_2=4.713;
F_99_1=6.763;
nu95_nt=a*(n^2-1)*F_95_2/(n*(n-a));
nu95_t = ((n-1)^2)*(a/(n-a-1))*F_95_1/(n*(1+(a*F_95_1)/(n-a-1)));
nu99_nt = a*(n^2 - 1)*F_99_2/(n*(n-a));
nu99_t = (n-1)^2*(a/(n-a-1))*F_99_1/(n*(1+(a*F_99_1)/(n-a-1)));
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
scatter(x1,y1)
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
scatter(x1,y1)
plot(vector_x95_t,vector_y95_t)
plot(vector_x99_t,vector_y99_t)
title("Test de Hotelling datos si están en training set")
xlabel("Proyección primera componente")
ylabel("Proyección segunda componente")
legend('PCA','umbral 95%','umbral 99%')