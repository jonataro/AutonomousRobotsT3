     %acotar una medida 0...2*p a -pi..pi a 
      function out = acotar180(in)
        if in>=pi%valores que se pasen de 360
            out = in - 2*pi;
        elseif in >= 2*pi
            out = in - 2*pi;
        else%valores entre 0 y 359 grados
            out = in;
        end
      end