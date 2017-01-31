function out_f = analyze_FFT(y, bit_len, fs)
  y = normalize(y);
  n = length(y);  
  y = fft(y);
  f = fs*(0:(n/2))/n;
  P = abs(y/n);
  fft = P(1:n/2+1);
  out_f = normalize(fft);
endfunction