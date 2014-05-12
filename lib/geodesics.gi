#Distances, geodesics and their numbers  in groups.
#All functions return associative lists.

#associates each group element with its length
InstallGlobalFunction(Distances,
function(G)
local lengths,i,o;
  lengths := AssociativeList();
  o := Orb(G, One(G), \*, rec(schreier:=true));
  Enumerate(o);
  for i in [1..Size(o)] do
    Assign(lengths,
           o[i],
           Length(TraceSchreierTreeForward(o,i)));
  od;
  return lengths;
end);

#associates each group element with its length
InstallGlobalFunction(Geodesic,
function(G)
local al,i,o;
  al := AssociativeList();
  o := Orb(G, One(G), \*, rec(schreier:=true));
  Enumerate(o);
  for i in [1..Size(o)] do
    Assign(al,
           o[i],
           TraceSchreierTreeForward(o,i));
  od;
  return al;
end);

#associates a group element with the set of all its geodesics
#this relies on Distances
InstallGlobalFunction(Geodesics,
function(G)
local geodesics,d,i,o, collector, limits;

  limits := Distances(G);
  geodesics := AssociativeList();
  d := MaxValueInAssociativeList(limits);
  #---------------------------------------
  collector := function (word,result)
    if Length(word) = limits[result] then
      if result in Keys(geodesics) then
        AddSet(geodesics[result],ShallowCopy(word));
      else
        Assign(geodesics,result,[ShallowCopy(word)]);
      fi;
    fi;
  end;
  #---------------------------------------
  StraightWords(One(G), GeneratorsOfGroup(G), \* , collector, d+1);
  return geodesics;
end);

#just getting the number of geodesics, but not the words while searching
#TODO this can be merged with Geodesics
InstallGlobalFunction(NumOfGeodesics,
function(G)
local numof,d,i,o, collector, limits;

  limits := Distances(G);
  numof := AssociativeList();
  d := MaxValueInAssociativeList(limits);
  #---------------------------------------
  collector := function (word,result)
    if Length(word) = limits[result] then
      if result in Keys(numof) then
        Assign(numof, result, numof[result]+1);
      else
        Assign(numof,result,1);
      fi;
    fi;
  end;
  #---------------------------------------
  StraightWords(One(G), GeneratorsOfGroup(G), \* , collector, d+1);
  return numof;
end);
