clear all;
format compact;
  cd 6
  filename = "../data.wav";
  pattern_filename = "../pattern.wav";
  show = 0;
  num_max_sample = 10;
  bit_ratio = 1/74;

  [tab_of_tab fs] = analyze_stream(filename, num_max_sample, bit_ratio);
  bit_len = bit_ratio * fs;
  pattern_i =  load_pattern(pattern_filename, num_max_sample, bit_len, fs, bit_ratio);
  
  [probability_i probability_i2] = probability2(tab_of_tab, pattern_i);
  alpha = (probability_i + probability_i2) * 0.5;

  x = 0:bit_ratio:length(probability_i)*bit_ratio-bit_ratio;

  img = zeros(50,size(probability_i,2));
  for iy=1:50
    img(iy,:) = uint8(256*probability_i);
  endfor
  
  pt_i = sum(alpha)/size(alpha,2)

  imwrite(uint8(img),'../out.png' );
