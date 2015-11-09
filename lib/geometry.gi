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
  local ab, ac, bc;
  ab := Interval(a,b,S,d);
  ac := Interval(a,c,S,d);
  bc := Interval(b,c,S,d);
  if a in bc then Print("mid:",a); return [a]; fi;
  if b in ac then Print("mid:",b); return [b]; fi;
  if c in ab then Print("mid:",c); return [c]; fi;
  return Intersection(Ball(G,a,DistanceFromSet(a, bc,d), d),
                      Ball(G,b,DistanceFromSet(b, ac ,d),d),
                      Ball(G,c,DistanceFromSet(c, ab,d),d));
end;
