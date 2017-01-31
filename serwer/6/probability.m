function probability_out = probability(a,b)
  for l = 1: size(a,1)
    c = a(l,2,:);
    c = squeeze(c)';
    
    probability_out(l) = u_test(c,b); %Wilcoxon rank-sum test
  endfor
endfunction