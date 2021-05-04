function plotrobotshape(shape,pose)
    ShapePlot = rotate(shape,rad2deg(pose.r),[0 0]);
    ShapePlot = translate(ShapePlot,[pose.x,pose.y]);
    plot(ShapePlot);
end