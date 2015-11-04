#Distances, geodesics and their numbers  in groups.
#All functions return associative lists.

# calculates the orbit of the elements of group G
# starting from the identity and stores the geodesic
# words transformed by function f in an associative list
# group element g -> f(geodesic to g)
TracedOrbit2LookupTable := function(G, f)
  local al,i,o;
  al := AssociativeList();
  o := Orb(G, One(G), \*, rec(schreier:=true));
  Enumerate(o);
  for i in [1..Size(o)] do
    Assign(al,
           o[i],
           f(TraceSchreierTreeForward(o,i)));
  od;
  return al;
end;
MakeReadOnlyGlobal("TracedOrbit2LookupTable");

#associates each group element with its length
InstallGlobalFunction(Distances,
function(G)
  return TracedOrbit2LookupTable(G, Length);
end);

# just to wraparound an associative list containing the distances
# in order to have a lookup table for distances
DistanceFunction := function(G)
local d;
  d := Distances(G);
  return function(g1, g2) return d[Inverse(g1)*g2];end;
end;

#associates each group element with its length
InstallGlobalFunction(Geodesics,
function(G)
  return TracedOrbit2LookupTable(G,x->x);
end);

#associates a group element with the set of all its geodesics
#this relies on Distances
InstallGlobalFunction(AllGeodesics,
function(G)
  local geodesics,d,i,o, collector, distances;
  distances := Distances(G);
  geodesics := AssociativeList();
  d := MaxValueInAssociativeList(distances);
  #---------------------------------------
  collector := function (word,result)
    if Length(word) = distances[result] then
      Collect(geodesics,result,ShallowCopy(word));
    fi;
  end;
  #---------------------------------------
  StraightWords(One(G), GeneratorsOfGroup(G), \* , collector, d+1);
  return geodesics;
end);

#just getting the number of geodesics, but not the words while searching
InstallGlobalFunction(NumOfGeodesics,
function(G)
  local numof,d,i,o, collector, distances;
  distances := Distances(G);
  numof := AssociativeList();
  d := MaxValueInAssociativeList(distances);
  #---------------------------------------
  collector := function (word,result)
    if Length(word) = distances[result] then
      Count(numof,result);
    fi;
  end;
  #---------------------------------------
  StraightWords(One(G), GeneratorsOfGroup(G), \* , collector, d+1);
  return numof;
end);
