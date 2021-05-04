function  outmapa = ultrasonidos(mapa,pose,mapareal,ultrasonic)
    % El programa recibe la posición, orientación del robot y el mapa actual
    % (el mapa del robot) y el real. Realiza la medida en la orientación
    % indicada (comprobando en el mapa real si existe algún objeto en el radio
    % de acción para simular el detectarlo) y actualiza el mapa de rejilla del
    % robot.

    %crear los puntos de rejilla coincidentes con el area de sensor segun la
    %pose de entrada
    SensorMesh=sensorarea(ultrasonic,pose);
    %inicializacion de la variable que indica la distancia del obstaculo mas
    %cercano
    nearestobstacle=ultrasonic.rmax+1;
    nobstacles=0;
    obstacle=false;
    outmapa=mapa;
    %calcular la distancia al obstaculo mas cercano
    
    for m=1:length(SensorMesh)
        %limitar el area del sensor al mapa
        if SensorMesh(m).x <= length(mapareal.M(1,:))   ...
        && SensorMesh(m).x >= 1                         ...
        && SensorMesh(m).y <= length(mapareal.M(2,:))   ...
        && SensorMesh(m).y >=  1
           x=SensorMesh(m).x;
           y=SensorMesh(m).y;
            %si uno de los puntos de la rejilla del sensor coincide con algun
            %obstaculo
           if mapareal.M(y,x)==1
               obstacle=true;%variable para debugear
               nobstacles= nobstacles + 1;%puntos de rejilla con obstaculo
               obstacleX(nobstacles)=x;%variable para debugear
               obstacleY(nobstacles)=y; %variable para debugear
               if SensorMesh(m).distance<nearestobstacle
                   nearestobstacle=SensorMesh(m).distance;
               end
           end
        end
    end
    
    testyes=0;
    testno=0;
    test=0;
    
    for n=1:length(SensorMesh)
        if SensorMesh(n).x <= length(mapareal.M(1,:))   ...
        && SensorMesh(n).x >= 1                         ...
        && SensorMesh(n).y <= length(mapareal.M(2,:))   ...
        && SensorMesh(n).y >=  1
            x=SensorMesh(n).x;
            y=SensorMesh(n).y;
            test=test+1;
            if nearestobstacle<=SensorMesh(n).distance ... 
            && SensorMesh(n).distance <=nearestobstacle+ultrasonic.epsilon  %
                SensorMapa(y,x) = 0.5+0.5/ultrasonic.kd;
                testyes=testyes+1;
            else
                SensorMapa(y,x) = 0.1;
                testno=testno+1;
            end
             %actualizacion del mapa usando logica bayesania
            outmapa(y,x)=   SensorMapa(y,x) * mapa(y,x) ...
                            /...%
            ((mapa(y,x)*SensorMapa(y,x)+(1-mapa(y,x))*(1-SensorMapa(y,x))));
        end
    end        

    
    % image(100*mapa);   
    %visualizar area coindicente de obsatculos y area sensor    
    if obstacle==true
        scatter(obstacleX,obstacleY,'+','r');
    end
end

    