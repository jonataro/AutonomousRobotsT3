%probar la funcion de Ultrasonidos para una pose donde sepamos que hay
%obstaculo en el rango dle sensor
clearvars;
close all;
MapaCargado=load('Mapa.mat');
mapareal.M=flip(MapaCargado.M);
mapa=0.5*ones(size(mapareal.M));
%image(100*mapareal.M);
    %configurar visualizacion   
    ax = gca; %declaracion variable tipo gca para congfigurar ejes de visualizacion
    ax.YDir = 'normal';%situar eje coordenadas visualizacion esquina inferior izquierda

pose.x=300;
pose.y=100;
pose.r=pi/6;
ultrasonic.tetha=30;
ultrasonic.rmin=0; 
ultrasonic.rmax=80; 
ultrasonic.epsilon=10;
ultrasonic.kd=3;

mapa=ultrasonidos(mapa,pose,mapareal,ultrasonic);
close;%cerrar el plot de debugg que gnera la funcion ultrasonidos
f1=figure('Name','mapa');
image(100*mapa)
ax = gca; %declaracion variable tipo gca para congfigurar ejes de visualizacion
ax.YDir = 'normal';%situar eje coordenadas visualizacion esquina inferior izquierda;

%vuelvo a llamar a ulttasonidos para visualizar el conjunto de puntos
%generado por la funcion ultrasonidos.m
hold on;mapa=ultrasonidos(mapa,pose,mapareal,ultrasonic);