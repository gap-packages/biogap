################################################################################
# Geometry on Cayley graphs.                                                   #
# (C) Copyright 2011-2015 Attila Egri-Nagy, Andrew Francis                     #
################################################################################

# G - group with distance function
# g - an element of G, the origo
# r - radius
InstallGlobalFunction(Circle,
function(g, r, G)
  local d;
  d := DistanceFunction(G);
  return Set(Filtered(G, x -> d(g,x) = r));
end);

InstallGlobalFunction(Ball,
function(g, r, G)
  local d;
  d := DistanceFunction(G);
  return Set(Filtered(G, x -> d(g,x)<= r));
end);

InstallGlobalFunction(DistanceFromSet,
function(g, A, G)
  local d;
  d := DistanceFunction(G);
  return Minimum(List(A, x-> d(g,x)));#TODO how about non-symmetric generating sets?
end);

Interior := function(a,b,c,G)
  local ab, ac, bc ,d;
  d := DistanceFunction(G);
  ab := Interval(a,b,G);
  ac := Interval(a,c,G);
  bc := Interval(b,c,G);
  if a in bc then return [a]; fi;
  if b in ac then return [b]; fi;
  if c in ab then return [c]; fi;
  return Intersection(Ball(a,DistanceFromSet(a,bc,G),G),
                      Ball(b,DistanceFromSet(b,ac,G),G),
                      Ball(c,DistanceFromSet(c,ab,G),G));
end;

# all triangles in group G with one vertex as ()
AllTriangles := function(G)
  local nontrivelts;
  nontrivelts := Difference(AsSet(G),[()]);
  return List(Combinations(nontrivelts, 2), x -> Union([()], x));
end;
