# returns the graded sets + the actual images in a recursive data structure
# g,h - group elements in <S>
# S - generating set
# d - precalculated distance function (optional, calculated if not supplied)
#TODO distance function may have different gen set
GradedInterval := function(g,h,G)
  local L, #the graded sets, layers
        n, # d(g,h)
        gp, # an element in the previous grade
        s, #generator
        i,j, # for indexing
        gps,
        images,
        numofedges,
        visited,
        ordered,
        S, # generators of G
        d; # distance function in G
  S := Generators(G);
  d := DistanceFunction(G);
  n := d(g,h); #the distance between the two elements
  L := [[g]]; # the first grade
  numofedges := List([1..n+1], x->0);
  ordered := [()];
  visited := [()];
  images := AssociativeList(); # group -> [[genindx, image]...]
  Assign(images,h,[]);
  # going through all grades
  for i in [1..n] do
    L[i+1]:=[];
    for gp in L[i] do # all elements in the previous grade
      for j in [1..Size(S)] do # all generator index
        s := S[j];
        gps := gp*s;
        if d(gps,h)=n-i then # if we stay on a geodesic
          if not gps in visited then
            AddSet(visited,gps);
            Add(ordered, gps);
          fi;
          numofedges[i] := numofedges[i]+1;
          AddSet(L[i+1],gps);
          Collect(images, gp,[j,gps]);
        fi;
      od;
    od;
  od;
  return rec(grades:=L,
             images:=images,
             widths:=List(L,Length),
             elts:=visited,
             nedges := numofedges);
end;

Interval := function(g,h,G)
  return Union(GradedInterval(g,h,G).grades);
end;

Profile := function(gi)
  return List([1..Size(gi.nedges)], x->[gi.widths[x],gi.nedges[x]]);
end;

#this is just a lower bound (zig-zag makes it so)
NumOfPathsLowerBound := function(gi)
  local i,diff,sum;
  sum := gi.nedges[1];
  for i in [2..Size(gi.nedges)] do
    diff := gi.nedges[i]-gi.nedges[i-1];
    if diff > 0 then sum := sum + diff; fi;
  od;
  return sum;
end;

#this is just a lower bound (zig-zag makes it so)
NumOfPaths := function(gi)
  local g,diff,sum;
  sum := 1;
  for g in Keys(gi.images) do
    diff := Size(gi.images[g])-1;
    if diff > 0 then sum := sum + diff; fi;
  od;
  return sum;
end;


ClassifyGroupElements := function(G)
  local d,g,gis;
  d := Distances(G);
  Print("Length classes:", Size(Keys(ReversedAssociativeList(d))));
  Print("\nWidth classes:", Size(Keys(ReversedAssociativeList(NumOfGeodesics(G)))));
  gis := AssociativeList();
  for g in G do
    Assign(gis, g, GradedInterval((),g,GeneratorsOfGroup(G),DistanceFunction(G)));
  od;
#  Print("\nInterval size classes:", Size(Keys(ReversedAssociativeList(TransformValues(gis,x->x.size)))));
  Print("\nProfile classes:", Size(Keys(ReversedAssociativeList(TransformValues(gis,x->Profile(x))))));
end;


# BINARY RELATIONS #############################################################
# the binary relation of the graded poset
GradedIntervalBinRel := function(gi)
local k,l,img;
  l := List([1..Size(Flat(gi.grades))], x-> []);
  gi.indices := AssociativeList(Flat(gi.grades));
  for k in Keys(gi.images) do
    for img in gi.images[k] do
      Add(l[gi.indices[k]],gi.indices[img[2]]);
    od;
  od;
  return BinaryRelationOnPoints(l);
end;

# VISUALISATION ################################################################
# parameters
DotInterval := function(arg)
  local str, i, map,gi,img, g, params;
  gi := arg[1];
  if IsBound(arg[2]) then
    params := arg[2];
  else
    params := rec(generators:=true, elements:=false, profile:=true);
  fi;
  str:="";
  Append(str,"//dot\n graph{ rankdir=BT;ranksep=.2; \n node [shape=circle,label=\"\",width=0.08]\n");
  if IsBound(params.elements) and  params.elements then 
    for g in gi.elts do
      Append(str, Concatenation(String(Position(gi.elts,g)), " [label=\"",String(g),"\"]\n"));
    od;
  fi;
  for g in Reversed(gi.elts) do
    for img in gi.images[g] do
      if IsBound(params.generators) and params.generators then
        Append(str,Concatenation(String(Position(gi.elts, g)), " -- ", String(Position(gi.elts,img[2])),
                "[label=\"",String(img[1]) ,"\"]\n"));
      else
        Append(str,Concatenation(String(Position(gi.elts, g)), " -- ", String(Position(gi.elts,img[2])),"\n"));
      fi;
    od;
  od;
  if IsBound(params.profile) and  params.profile then 
    Append(str,Concatenation("prof [shape=record,label=\"",
            Concatenation(List(Reversed(Profile(gi)), l-> Concatenation(String(l),"\\n"))),
            "\",color=\"black\"]\n"));
  fi;
  # if IsBound(arg[2]) then
  #   Append(str,Concatenation("tag [shape=record,label=\"",
  #           arg[2],
  #           "\",color=\"black\"]\n"));
  

  Append(str, " }");
  return str;
end;
