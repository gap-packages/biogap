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
  return Set(Filtered(G, x -> d(g,x) = r));
end);

InstallGlobalFunction(Ball,
function(G, g, r, d)
  return Set(Filtered(G, x -> d(g,x)<= r));
end);

InstallGlobalFunction(DistanceFromSet,
function(g, A, d)
  return Minimum(List(A, x-> d(g,x)));#TODO how about non-symmetric generating sets?
end);

Interior := function(a,b,c,G, S,d)
  return Intersection(Ball(G,a,DistanceFromSet(a, Interval(b,c,S,d),d),d),
                      Ball(G,b,DistanceFromSet(b, Interval(a,c,S,d),d),d),
                      Ball(G,c,DistanceFromSet(c, Interval(a,b,S,d),d),d));
end;
