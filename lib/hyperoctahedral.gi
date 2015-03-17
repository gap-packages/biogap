###########################################################
# Different generating sets for the hyperoctahedral       #
# groups and some subgroups with fixed terminus.          #
# (C) Copyright 2011-12 Attila Egri-Nagy, Andrew Francis  #
###########################################################

########################################################
#The 'algebraic' generator set                         #
# cycle, a transposition and a sign flipping           #
# Note: first two are not inversions                   #
########################################################
#TODO what happens when n=1?
InstallGlobalFunction(HyperOctahedralAlgebraicGens,
function(n)
local gens,l;
  gens := [];
  #transposition
  l := [1..n];
  l[2] := 1;
  l[1] := 2;
  Add(gens,SignedPermutation(l));
  #cycle
  l := [2..n];
  Add(l,1);
  Add(gens,SignedPermutation(l));
  #sign flipping
  l := [1..n];
  l[1] := -1;
  Add(gens,SignedPermutation(l));
  return gens;
end);

#not necessarily a generating set, but can be used for building one
InstallGlobalFunction(AllInversionsOfSize,
function(n,k)
  return DuplicateFreeList(List(CircularBlocksOfSize(n,k),
                 x -> CircularBlock2Inversion(n,x)));
end);

InstallGlobalFunction(HyperOctahedralLimitedLengthInversionGens,
function(n,l)
  return DuplicateFreeList(List(LimitedCircularBlocks(n,l),
                 x -> CircularBlock2Inversion(n,x)));
end);

InstallGlobalFunction(HyperOctahedralAllInversionsGens,
function(n)
  return DuplicateFreeList(List(CircularBlocks(n),
                 x -> CircularBlock2Inversion(n,x)));
end);
