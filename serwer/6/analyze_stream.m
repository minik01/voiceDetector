function [tab_of_tab fs] = analyze_stream(filename, num_max_sample, bit_ratio)
  
  % wczytanie pliku
  [y,fs] = audioread(filename);
  bit_len = bit_ratio * fs;

  %y = y(1:length(y)/16); %%TEMP!!!!!!
  
  % ciecie pliku
  elems = floor( length(y)/bit_len );
  y = y(1:elems*bit_len);

  tab_of_tab = double(zeros(elems,2,num_max_sample));
  for l = 0:elems-2;
    start =uint32(l*bit_len+1);
    stop = uint32((l+1)*bit_len );
    fft = analyze_FFT(y(start:stop), bit_len, fs);
    [fft tab] = filter_max(fft,num_max_sample);
    tab_of_tab(l+1,:,:) = tab;
  endfor
endfunction