%plotrobotshapeTest

%declaracion de estructuras************************************************
   	Pose = struct('x',[],'y',[],'r',[]);
    
%dimensiones del robot 10x20 cm (anchoxlargo).
    a=10;%ancho
    l=20;%largo
    
%poligono que representa el robot con su centro gravedad 
%referenciada en el origen    
    MyRobot.Shape = polyshape([-a/2 -a/2 a/2 a/2 ],[l/2 -l/2 -l/2 l/2 ]);
    MyRobot.WheelRadius=5;%Wheels radius
    MyRobot.WheelDistance=10;% linear distance beween two wheels
    MyRobot.PulsePerRev=100;%pulses of incremental encoder per revolution

%DEFINIR DOS POSES
    
    Pose(1).x=0;
    Pose(1).y=0;
    Pose(1).r=0;
    
    Pose(2).x=20;
    Pose(2).y=10;
    Pose(2).r=90;
    
    
    Pose(3).x=-20;
    Pose(3).y=-10;
    Pose(3).r=-90;
    
    hold on;
    for i=1:3
        plotrobotshape(MyRobot.Shape,Pose(i));
    end
   
   
    