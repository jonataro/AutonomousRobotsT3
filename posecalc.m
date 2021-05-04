function [pose,dr,dl,d,rho]=posecalc(lastpose,nr,nl,robot)
%every wheeel displacement
    dr=nr*2*pi*robot.WheelRadius/robot.PulsePerRev;
    dl=nl*2*pi*robot.WheelRadius/robot.PulsePerRev;
%angular displacement
    rho=(dr-dl)/robot.WheelDistance;        
%absolut displacement
    d=(dr+dl)/2;
%pose calculation         
    pose.r = lastpose.r + rho;
    pose.x = lastpose.x + d*cos(pose.r);
    pose.y = lastpose.y + d*sin(pose.r);           
end
