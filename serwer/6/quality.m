function q = quality(tab)
  global tab_of_tab
  y = probability(tab_of_tab(:,2,:),tab);
  q = -sum(y);
end