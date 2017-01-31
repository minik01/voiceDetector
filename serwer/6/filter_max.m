function [out_y tab] = filter_max(y, N)
  n = length(y);
  out_y = zeros(1,n);

  for (cnt = 1:N)  
    [max_v, max_i] = max(y);   
    out_y(max_i) = max_v;
    y(max_i) = 0;
  end
  
  if (nargout==2)
    tab = zeros(2,N);
    found = 1;
    for (i=1:n) 
      if(found==N+1)
        break;
      endif
      if (out_y(i)!=0)
        tab(1,found) =i;
        tab(2,found) =out_y(i);
        found++;
      end
    end
  endif
endfunction