%senorareaTEST
clear vars
close
%cargaparametros
    pose.x=300;
    pose.y=100;
    pose.r=pi/6;
    ultrasonic.tetha=30;
    ultrasonic.rmin=0; 
    ultrasonic.rmax=80; 
    ultrasonic.epsilon=10;
    ultrasonic.kd=3;
 
SensorMesh=sensorarea(ultrasonic,pose);