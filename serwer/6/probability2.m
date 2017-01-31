function [po1 po2] = probability2(a,b)
  for l = 1: size(a,1)
    a2 = a(l,2,:);
    a2 = squeeze(a2)';
    
    c = a(l,1,:);
    c = squeeze(c)';

    po1(l) = u_test(a2,b(2,:)); %Wilcoxon rank-sum test
    po2(l) = u_test(c,b(1,:));
  endfor
endfunction