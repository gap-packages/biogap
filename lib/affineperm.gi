###########################################################
# Affine permutations                                     #
# (C) Copyright 2011-12 Attila Egri-Nagy, Andrew Francis  #
###########################################################

#the length function that works with affine permutations
InstallGlobalFunction(ShiLength,
function(l)
  local i,j,len,n;
  len := 0;
  n := Length(l);
  for j in [1..n] do
    for i in [1..j-1] do
      len := len + AbsInt(Int(Floor(Float((l[j]-l[i])/n))));
    od;
  od;
  return len;
end);
