###########################################################
# Blocks of regions of a circular genome.                 #
# (C) Copyright 2011-12 Attila Egri-Nagy, Andrew Francis  #
###########################################################

# going around the circular genome, like modulo, but start with 1
# returns the modulo n value but never returns 0
BIOGAP_CircularMod := function(n,y)
  if y>n then return y mod n; fi;
  return y;
end;

#length between two regions, calculated clockwise
BIOGAP_CircularLength := function(n,x,y)
  if x>y then
    return n+y-x +1;
  else
    return y-x +1;
  fi;
end;

# creating a circular block, taking care of bending around the origin
#n number of regions, first and last region in the block
InstallGlobalFunction(CircularBlock,
function(n,first,last)
  if first <= last then
    return [first..last];
  else
    return List([first..last+n], x->BIOGAP_CircularMod(n,x));
  fi;
end);

# blocks of a given size, all over the genome
InstallGlobalFunction(CircularBlocksOfSize,
function(n,size)
local firsts, lasts;
  firsts := [1..n];
  lasts := List([1..n], x->BIOGAP_CircularMod(n,x+size-1));
  return List([1..Size(firsts)],
              x -> CircularBlock(n,firsts[x],lasts[x]));
end);


InstallGlobalFunction(LimitedCircularBlocks,
function(n,l)
  return Concatenation(
                 List([1..l], x->CircularBlocksOfSize(n,x)));
end);

# all blocks of all over the genome
InstallGlobalFunction(CircularBlocks,
function(n)
  return LimitedCircularBlocks(n,n);
end);


# for n elements sublists between k and l with length m
InstallGlobalFunction(CircularBlocksOfSizeWithin,
function(n,first,last,size)
local firsts, lasts, length, numofblocks;
  length := BIOGAP_CircularLength(n,first,last);
  numofblocks := length - size +1;
  firsts := List([1..numofblocks], x->BIOGAP_CircularMod(n,first+x-1));
  lasts := List([1..numofblocks], x->BIOGAP_CircularMod(n,first+size-1+x-1));
  return List([1..Size(firsts)],
              x -> CircularBlock(n,firsts[x],lasts[x]));
end);

# returns all contiguous sequences from k to l of all sizes >=1
InstallGlobalFunction(CircularBlocksWithin,
function(n,k,l)
local maxsize;
    maxsize := l-k+1;
    if k > l then
      maxsize := maxsize + n;
    fi;
    return Concatenation(List([1..maxsize],
                   x-> CircularBlocksOfSizeWithin(n,k,l,x)));
end);

#from a block we create an inversion - pad it with the identity,
#then concat the reversed block with switched signs
InstallGlobalFunction(CircularBlock2Inversion,
function(n,block)
local pos, inversed, l;
  if IsEmpty(block) then return SignedPermutation([]); fi;
  inversed := Reversed(block)*(-1);
  if block[1] <= LastElementOfList(block) then
    #just padding from the beginning
    return SignedPermutation(
                   Concatenation([1..block[1]-1],
                           inversed));
  else
    #need to cut over the origin
    pos := Position(block,1); #we find the position of 1
    l := Length(block);
    return SignedPermutation(
                   Concatenation(inversed{[pos..l]},
                           [l-pos+2..n-pos+1],
                           inversed{[1..pos-1]}));
  fi;
end);
