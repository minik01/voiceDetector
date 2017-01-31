function yn = normalize(y)
  yn = y/max([max(y), abs(min(y))]);
end