#clear all;
format compact;


%const
  filename = "../data.wav";
  pattern_filename = "../pattern.wav";
  filename2 = "../training_not.wav";
  show = 0;
  num_max_sample = 10;
  bit_ratio = 1/75

  q1 = quality2(filename, pattern_filename, num_max_sample, bit_ratio)
  q2 = quality2(filename2, pattern_filename, num_max_sample, bit_ratio)

  q_val = q1/q2
  
