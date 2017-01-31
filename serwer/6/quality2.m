function [pt_i] = quality2(filename, pattern_filename, num_max_sample, bit_ratio)

  [tab_of_tab fs] = analyze_stream(filename, num_max_sample, bit_ratio);
  bit_len = bit_ratio * fs;
  pattern_i =  load_pattern(pattern_filename, num_max_sample, bit_len, fs, bit_ratio);
  [probability_i probability_i2] = probability2(tab_of_tab, pattern_i);
  alpha = (probability_i + probability_i2) * 0.5;
  pt_i = sum(alpha)/size(alpha,2);
endfunction