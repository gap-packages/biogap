#acting on the list elements
InstallGlobalFunction(OnListByCont,
function(l, t)
  return List([1..Length(l)], x -> l[x]^t);
end);

#acting on the positions - it makes sense only for permutations
#since collapsing positions is not defined
#TODO without inverting
InstallGlobalFunction(OnListByPos,
function(l, perm)
  local inv;
  inv := Inverse(perm);
  return List([1..Length(l)], x -> l[x^inv]);
end);