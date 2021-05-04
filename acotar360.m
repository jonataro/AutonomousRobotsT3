%acotar una medida -pi..pi a 0...2*pi 
function out = acotar360(in)
    if in < 0%valores negativos
        out = in + 2*pi ;
    elseif in>=2*pi%valores que se pasen de 360
        out = in - 2*pi;
    else%valores entre 0 y 359 grados
        out = in;
    end
end