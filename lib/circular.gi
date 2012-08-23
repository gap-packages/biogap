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