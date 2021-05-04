%*********************************robot.m**********************************
%Robotica autonoma 
%Master sistemas y control UNED&UCM
%Curso 2020-2021
%Autor: Jonatan Rodriguez jonataro@ucm.es
%Abstract: Construccion de mapa de rejilla, se actualizara la informacion
%sensorial obtenida mediante la teoria bayesiana

%limpieza imagenes y variables del workspace*******************************
    close all;
    clearvars;
    
%declaracion de estructuras************************************************
   	Pose = struct('x',[],'y',[],'r',[]);
    
%0-Parametros simulación*************************************************** 
    %lectura datos encoder
    E=load('Encoder.mat');
    NL=(E.Enc(:,1));%=>encoder rueda izquierda 
    NR=(E.Enc(:,2));%=>encoder rueda derecha
    samples=length(E.Enc);%el numero de muestras de los encoderes determina
    %el nuemro de veces a recalcular la porsicion del robotse 
    iterations=samples+1;%para tener en cuenta la posicion en el momento 
    %t=0 se crea un indice  
    
    %datos del modelo deml mapa real e incializacion del mapa a coonstruir
    MapaCargado=load('Mapa.mat');
    MapaReal.M=flip(MapaCargado.M);
    Mapa=0.5*ones(size(MapaReal.M));    
    %MapaAnterior=Mapa;
   
    %modelo del sensor de distancia
    Ultrasonic.tetha=30;
    Ultrasonic.rmin=0; 
    Ultrasonic.rmax=80; 
    Ultrasonic.epsilon=10;
    Ultrasonic.kd=3;
    Ultrasonic.n=1;%;360/30;%numero de medidas
    Ultrasonic.m=0;%*pi/Ultrasonic.n;%grados a girar en cada medida

    %dimensiones del robot 10x20 cm (anchoxlargo).
    a=10;%ancho
    l=20;%largo
    
    %poligono que representa el robot con su centro gravedad 
    %referenciada en el origen    
    MyRobot.Shape = polyshape([-a/2 -a/2 a/2 a/2 ],[l/2 -l/2 -l/2 l/2 ]);
    MyRobot.WheelRadius=5;%Wheels radius
    MyRobot.WheelDistance=10;% linear distance beween two wheels
    MyRobot.PulsePerRev=100;%pulses of incremental encoder per revolution
    
%Inicializacion variables************************************************
    %declaracion de vectores auxuiliares para mejorar el rendimiento de
    %ejecucion del script
    DR=zeros(iterations,1);% vector con el desplazamiento de la rueda dcha
    DL=zeros(iterations,1);% vector con el desplazamiento de la rueda izq
    D=zeros(iterations,1); % vector con el incremntos de posicion
    RHO=zeros(iterations,1);%vector con el giro incremental
 
 %1-posicion inicial del robot*********************************************
    Pose(1).x=200;
    Pose(1).y=100;
    Pose(1).r=0;

 %Bucle   
     for i=1:iterations
        j=i+1;%indice para añadir el punto de trayectoria antes de la 
        %primera lectura de encoders
        
        %-escaneo*********************************************************
        %b)medir solo en los puntos en los que el robot esta parado
        ScanCondition =(D(i)==0); %true;% 
        if ScanCondition == 1
            m = Ultrasonic.m;
            PoseAux=Pose(i);
            for n=1:Ultrasonic.n
                Mapa = ultrasonidos(Mapa,PoseAux,MapaReal,Ultrasonic);
                close;
                PoseAux.r = acotar180(acotar360(PoseAux.r + m));
            end
        end

        %actualizar posicion del robot segun cuentas encoder***************
        if i<iterations
        [Pose(j),DR(j),DL(j),D(j),RHO(j)]=...
            posecalc(Pose(i),NR(i),NL(i),MyRobot);
        end
     end
    
	% visualization
        f1=figure('Name','Trayectoria');
        %image(100*Mapa);
        image(100*MapaReal.M);
          %configurar visualizacion   
          ax = gca; %declaracion variable tipo gca para congfigurar ejes de
          %visualizacion
          ax.YDir = 'normal';%situar eje coordenadas visualizacion esquina 
          %inferior izquierda
          hold on;
          an=animatedline('Color','r','LineWidth',3);
          paradas=0;
          for k = 1:iterations
            addpoints(an,Pose(k).x,Pose(k).y);%addpoints(an,X(k),Y(k));
            drawnow %limitrate

            if D(k)==0 
                paradas=paradas+1;
                plotrobotshape(MyRobot.Shape,Pose(k))
            end
          end
          