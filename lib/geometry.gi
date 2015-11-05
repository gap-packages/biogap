################################################################################
# Geometry on Cayley graphs.                                                   #
# (C) Copyright 2011-2015 Attila Egri-Nagy, Andrew Francis                     #
################################################################################

# G - group
# g - an element of G, the origo
# r - radius
# d - distance function of G (using its generating set)
InstallGlobalFunction(Circle,
        function(G, g, r, d)
  return Filtered(G, x -> d(g,x) = r);
end);

InstallGlobalFunction(Ball,
function(G, g, r, d)
  return Filtered(G, x -> d(g,x)<= r);
end);
