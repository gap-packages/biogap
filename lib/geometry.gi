################################################################################
# Geometry on Cayley graphs.                                                   #
# Using a distance function we compute 'geometric' objects in the Cayley graph.#
# (C) Copyright 2011-2017 Attila Egri-Nagy, Andrew Francis                     #
################################################################################

# DistanceFunction is an attribute, so it is stored for subsequent calls

# G - group with distance function
# g - an element of G, the centre of the circle
# r - radius
# brute force filtering of the elements exactly r away from g
InstallGlobalFunction(Circle,
function(g, r, G)
  local d;
  d := DistanceFunction(G);
  return Filtered(G, x -> d(g,x) = r);
end);

InstallGlobalFunction(Ball,
function(g, r, G)
  local d;
  d := DistanceFunction(G);
  return Filtered(G, x -> d(g,x)<= r);
end);

# unless the generating set is symmetric, we have different to and from
# distances
InstallGlobalFunction(DistanceToSet,
function(g, A, G)
  local d;
  d := DistanceFunction(G);
  return Minimum(List(A, x-> d(g,x)));
end);

InstallGlobalFunction(DistanceFromSet,
function(g, A, G)
  local d;
  d := DistanceFunction(G);
  return Minimum(List(A, x-> d(x,g)));
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
  # TODO Should this be DistanceTo? shall we have two versions?
  return Intersection(Ball(a,DistanceFromSet(a,bc,G),G),
                      Ball(b,DistanceFromSet(b,ac,G),G),
                      Ball(c,DistanceFromSet(c,ab,G),G));
end;

Circumference := function(a,b,c,G)
  local d;
  d := DistanceFunction(G);
  return d(a,b) + d(b,c) + d(c,a);
end;

# all triangles in group G with one vertex as ()
AllTriangles := function(G)
  local nontrivelts;
  nontrivelts := Difference(AsSet(G),[()]);
  return List(Combinations(nontrivelts, 2), x -> Union([()], x));
end;
