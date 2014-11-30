################################################################################
# Basic functions for a circular genome.                                       #
# (C) Copyright 2011-12 Attila Egri-Nagy, Andrew Francis                       #
################################################################################

# going around the circular genome, like modulo, but start with 1
# returns the modulo n value but never returns 0
InstallGlobalFunction(CircularMod,
function(n,y)
  if y > n then return y mod n; fi;
  if y < 1 then return y + n; fi;
  return y;
end);

#the distance of region x and y on a circular genome of n regions
InstallGlobalFunction(CircularDist,
function(n,x,y)
  return Minimum(AbsInt(x-y), x-y+n, y-x+n);
end);

#all swaps on circular genome
InstallGlobalFunction(CircularTranspositions,
function(n)
   return List([1..n], x -> (x,CircularMod(n,x+1)));
end);

#just the linear swaps
InstallGlobalFunction(LinearTranspositions,
function(n)
   return List([1..n-1], x -> (x,x+1));
end);

InstallGlobalFunction(AllTranspositions,
function(n)
  return DuplicateFreeList(
          List(UnorderedTuples([1..n],2),
               function(p)
                 if (p[1]<>p[2]) then
                   return (p[1],p[2]);
                 else
                   return ();fi;
                 end));
end);
