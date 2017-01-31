function tab_of_patterns = my_ga(iter, max_patterns, num_max_sample)
  
  tab_of_patterns = rand(max_patterns,1+num_max_sample);
  delim1 = floor(size(tab_of_patterns,1)/4);
  delim2 = 2*delim1;
  delim3 = 3*delim1;
  delimEnd = size(tab_of_patterns,1);
  
  mutationSize = ones(size(tab_of_patterns));
  for (k=1:delimEnd) 
    mutationSize(k,:) = mutationSize(k,:)* double((k-1)*0.5/delimEnd);
  endfor 
  tab_of_patterns(:,1) = zeros(1,max_patterns);
  if(exist ("data/tab_of_patterns.m"))
    load("data/tab_of_patterns.m")
  else
    global bit_ratio
    
    pattern_a =  load_pattern("data/a.wav", num_max_sample, bit_ratio);
    pattern_e =  load_pattern("data/e.wav", num_max_sample, bit_ratio);
    pattern_i =  load_pattern("data/i.wav", num_max_sample, bit_ratio);
    pattern_o =  load_pattern("data/o.wav", num_max_sample, bit_ratio);
    pattern_u =  load_pattern("data/u.wav", num_max_sample, bit_ratio);
    pattern_y =  load_pattern("data/y.wav", num_max_sample, bit_ratio);
    tab_of_patterns(1,2:size(tab_of_patterns,2)) = pattern_a(2,:);
    tab_of_patterns(2,2:size(tab_of_patterns,2)) = pattern_e(2,:);
    tab_of_patterns(3,2:size(tab_of_patterns,2)) = pattern_i(2,:);
    tab_of_patterns(4,2:size(tab_of_patterns,2)) = pattern_o(2,:);
    tab_of_patterns(5,2:size(tab_of_patterns,2)) = pattern_u(2,:);
    tab_of_patterns(6,2:size(tab_of_patterns,2)) = pattern_y(2,:);
    
  endif

  for (i=1:iter) 
    tab_of_patterns = sortrows(tab_of_patterns);
    tab_of_patterns(delim1+1:delim2,:) = tab_of_patterns(1:delim1,:);
    mutation = (rand(max_patterns,1+num_max_sample)-0.5) .* mutationSize;
    tab_of_patterns = mod(tab_of_patterns + mutation,1);
          
    for (k=1:max_patterns) 
      tab_of_patterns(k,1) = quality(tab_of_patterns(k,2:num_max_sample));
    endfor
  endfor 
  tab_of_patterns = sortrows(tab_of_patterns);
  %  quality(pattern_a(2,:))
  save("data/tab_of_patterns.m", "tab_of_patterns")
  max_Q= -min(floor(tab_of_patterns(1,:)))
endfunction