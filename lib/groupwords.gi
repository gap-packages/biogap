InstallGlobalFunction(AugmentWithInverses,
function(gens)
  return Concatenation(gens, List(gens, x -> Inverse(x)));
end);

InstallGlobalFunction(DecodeAugmentedInverses,
function(w,n)
  return List(w, function(x) if x > n then return -(x-n); else return x;fi;end);
end);

################################################################################
# INVERSES included in the words ###############################################

InstallGlobalFunction(ConstructWithInverses,
function(sequence, generators, start, action)
local product,i;
  product := start;
  for i in [1..Length(sequence)] do
    if sequence[i] > 0 then
      product := action(product, generators[sequence[i]]);
    else
      #This works only for invertible generators, so one should be careful!
      #TODO calculating the inverses could be useful
      product := action(product, Inverse(generators[-sequence[i]]));
    fi;
  od;
  return product;
end);

InstallGlobalFunction(TrajectoryWithInverses,
function(sequence, generators, start,action)
local trajectory,i;
  trajectory := [start]; #so the images are off by 1
  for i in [1..Length(sequence)] do
    if sequence[i] > 0 then
      Add(trajectory,action(trajectory[i], generators[sequence[i]]));
    else
      Add(trajectory,action(trajectory[i], Inverse(generators[-sequence[i]])));
    fi;
  od;
  return trajectory;
end);

InstallGlobalFunction(Reduce2StraightWordWithInverses,
function(word, gens, point, action)
local reduced;
  #we reduce the word symbolically first (cancelling inverses)
  reduced := SymbolicReduced(word);
  #we create the trajectory by the invertible word and also cancel
  return StraightenWord(reduced,
                 TrajectoryWithInverses(reduced,gens,point,action));
end);

InstallGlobalFunction(SymbolicInverse,
function(sequence)
local i,inverted;
  inverted := [];
  for i in Reversed([1..Length(sequence)]) do
    Add(inverted, -sequence[i]);
  od;
  return inverted;
end);

#just the usual cancellation of inverses
InstallGlobalFunction(SymbolicReduced,
function(sequence)
local i;
  i:=1;
  while i <  Length(sequence) do
    if sequence[i] = (-sequence[i+1]) then
      Remove(sequence,i+1);#these shift the above elements
      Remove(sequence,i);
      if i > 1 then i := i -1; fi; # there can be some further collapsings
    else
      i := i+1;
    fi;
  od;
  return sequence;
end);

#l - length of the word, n - number of generators
InstallGlobalFunction(RandomWordWithInverses,
function(l,n)
local list;
  list := Concatenation([1..n],[1..n]*-1);
  return List([1..l], x->Random(list));
end);
