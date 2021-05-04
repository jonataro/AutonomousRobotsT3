function mymesh=sensorarea (ultrasonic,pose)
    %marcar los angulos limite segun la apertura del sensor(osara a radianes)
    tethapose=acotar360(pose.r);
    %tethadeg_pose = rad2deg(tethapose);
    tetha_rad = deg2rad(ultrasonic.tetha);
    tethapos = acotar180(tethapose+tetha_rad/2);
    tethaneg = acotar180(tethapose-tetha_rad/2);
    %tethadeg_pos_ = rad2deg(tethapos);
    %tethadeg_neg_ = rad2deg(tethaneg);
    
    %marcar los limites para definir la rejilla que determina el area del sensor 
    xmin=round(pose.x-ultrasonic.rmax);
    xmax=round(pose.x+ultrasonic.rmax);
    ymin=round(pose.y-ultrasonic.rmax);
    ymax=round(pose.y+ultrasonic.rmax);

    %bucle que proporciona las coordenadas de rejilla del area de sensor
    %para segun la pose
    i=1;
    for  x=xmin:xmax
        for y=ymin:ymax
            [angle,distance]=cart2pol((x-pose.x),(y-pose.y));
            if  0   <= tethaneg && tethaneg <= pi ... 
            &&  -pi <= tethapos && tethapos <  0
                AngleBetweenLimits = (tethaneg <= angle && angle<=pi...
                                     ||  -pi <= angle && angle<=tethapos);
            else                
                AngleBetweenLimits = (tethaneg <= angle && angle<= tethapos);
            end
            
            DistanceBetweenLimits =     distance>=ultrasonic.rmin ...
                                    &&  distance<=ultrasonic.rmax ;
            
            if  DistanceBetweenLimits && AngleBetweenLimits
                mymesh(i).x = x;
                mx(i)=x;
                mymesh(i).y = y;
                my(i)=y;
                mymesh(i).distance=distance;
                mymesh(i).angle=rad2deg(angle);
                i=i+1;
            end
        end
    end
    scatter(mx,my,'B');
    
%las siguientes funcionen surgen por que los valores depose vienen en
%rangos de+-180 grados,se cambian estos limites estas limites a 0..359 grados 
%para poder sumar y restar los limites que representan el angulo de apertura
%del sensor yluego se pasa otra ves de limites +-180 grados




 end