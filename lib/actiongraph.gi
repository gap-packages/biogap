################################################################################
# Implementation of search algorithms in action graphs.                        #
# (C) Copyright 2011-2012 Attila Egri-Nagy, Andrew Francis                     #
################################################################################

#homebrew breadth-first search from x to y by a word of gens
#sorted list based
InstallGlobalFunction(ActionGraphSearchSlow,
function(x,y,gens,action)
local visited,w,i,nx,ny,storage, id;
  #the identity can do the job
  if x = y then return [];fi;

  id := One(gens[1]);
  storage := Queue();
  visited := [];
  Store(storage, []);

  while not IsEmpty(storage) do
    #the next word to be extended
    w := Retrieve(storage);
    #we precalculate this part to avoid several word evaluations
    nx := action(x,ConstructWithInverses(w,gens,id,\*));
    #extension
    for i in [1..Length(gens)] do
      Add(w,i);
      ny := action(nx,gens[i]);
      if ny = y then return w; fi;
      if  not ny in visited  then
        AddSet(visited,ny);
        Store(storage,ShallowCopy(w));
      fi;
      Remove(w);#remove last
    od;
  od;
  return fail;
end);

# Orb's orbit algorithm used here, hashtable based
InstallGlobalFunction(ActionGraphSearch,
function(x,y,gens,action)
local o, pos;
  #the identity can do the job
  if x = y then return [];fi;

  #the orbit calculation
  o := Orb(gens, x, action, rec(schreier:=true, lookingfor:=[y]));
  Enumerate(o);

  #checking the results
  pos := PositionOfFound(o);
  if pos = false then
    return fail;
  else
    return TraceSchreierTreeForward(o,pos);
  fi;
end);

#distance is simply the length of the word between
InstallGlobalFunction(WordDistance,
function(x,y,gens,action)
  return Length(ActionGraphSearch(x,y,gens,action));
end);

#based on straight word backtrack - very slow
InstallGlobalFunction(GeodesicWords,
function(x,y,gens,action)
local limit,l;
  limit := WordDistance(x,y,gens,action);
  l := [];
  StraightWords(x,gens,action,SWP_Search(l,y),limit);
  return l;
end);
