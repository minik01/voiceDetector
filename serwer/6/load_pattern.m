function pattern = load_pattern(filename, num_max_sample, bit_len, fs, bit_ratio)
  % wczytanie pliku
  [y,fs] = audioread(filename);
  bit_len = 1/16 * fs;

  % ciecie pliku
  y = y(1:bit_len);

  %bez ciecia
  %bit_len = length(y)
  
  %PATTERN
  fft = analyze_FFT(y, bit_len, fs);
  [fft pattern] = filter_max(fft,num_max_sample);

endfunction

function pattern = load_pattern(filename, num_max_sample, bit_len)
  pattern = load_pattern(filename, num_max_sample, bit_len,44100);
endfunction