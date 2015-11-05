################################################################################
# Geometry on Cayley graphs.                                                   #
# (C) Copyright 2011-2015 Attila Egri-Nagy, Andrew Francis                     #
################################################################################

InstallGlobalFunction(Ball,
function(G, g, r, d)
  return Filtered(G, x -> d(g,x)<= r);
end);
