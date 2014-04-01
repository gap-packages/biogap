#geodesics for circular unsigned configurations by 2-inversions
#we represent the circular genome by a list not a permutation
R8example := [3,8,5,2,7,4,1,6];

MinimizePath := function(n,i,si)
local d;
  d := AbsInt(i-si); #the distance between the position and its target
  if AbsInt(i-(si+n)) < d then
    return si + n; #it is shorter going up
  elif AbsInt(i-(si-n)) < d then
    return si-n; #it is shorter going down
  else
    return si;
  fi;
end;

#making the given permutation into an affine by rerouting
#the threads the shorter way (decisions about equal length threads
#are made here)
MinimizePaths := function(l)
local n;
  n := Size(l);
  return List([1..n], i -> MinimizePath(n,i,l[i]));
end;

#collecting the configurations with minimal length in the dihedral orbit
#also returning the dihedral elements
MinimalReps := function(l)
local dihedrals, n, rewired, orb, shilengths, min, poss;
  n := Size(l);
  dihedrals := AsList(DihedralGroup(IsPermGroup, 2*n));
  orb := List(dihedrals, g-> OnListByPos(l,g));
  rewired := List(orb, x->MinimizePaths(x));
  shilengths := List(rewired, x->ShiLength(x));
  min := Minimum(shilengths);
  poss := Positions(shilengths, min);
  return rec(
             actions:=List(poss, i->dihedrals[i]),
             configs:=List(poss, i->orb[i]),
             length:=min
             );
end;

#calculates the length of a permutation (generators: circular 2-inversions)
#the permutation is converted to a list of images, then the orbit under
#the symmetries is calculated, after reouting the Shi Length is calculated
#then the minimum value is returned
CircularTwoInversionsLength := function(l)
  return MinimalReps(l).length;
end;

#the same length but with actual brute force calculation
CircularTwoInversionsLengthBF := function(l)
local orb,n;
  n:=Size(l);
  orb := List(DihedralGroup(IsPermGroup,2*n), g->OnListByPos(l,g));
  return Minimum(List(orb,
                 x-> WordDistance([1..n],
                         x,
                         CircularTranspositions(n),
                         OnListByPos)));
end;

#sorting by uncrossing
Circular2InvSort := function(l)
  local w,finished,
        d, #the distance for each region
        n,tmp,i,src,
        m, #all paths minimized in l
        s; #the successor region
  n := Size(l);
  src := ShallowCopy(l);
  m := MinimizePaths(src);
  d := List([1..n], x -> m[x] - x);
  w := [];
  repeat
    finished := true;
    for i in [1..n] do
      s := CircularMod(n,i+1);
      if d[i] > d[s] then
        tmp := src[i];
        src[i] := src[s];
        src[s] := tmp;
        #just update the distance vector
        d[i] := MinimizePath(n,i,src[i]) - i;
        d[s] := MinimizePath(n,s,src[s]) - s;
        Add(w,i);
        finished := false;
        break;
      fi;
    od;
  until finished;
  if Size(AsSet(d)) <> 1 then
    Error("Goal not achieved! Nonidentical distances");
  fi;
  return w;
end;

CheckCircularSorting := function(l)
local n, targets, result,minreps,i,w,D,orb, config;
  n := Size(l);
  D := DihedralGroup(IsPermGroup,2*n);
  orb := List(D, g-> OnListByPos(l,g));

  targets := List(D, g -> OnListByPos([1..n],g));
  for config in orb do
    w := Circular2InvSort(config);
    if Size(w) <> ShiLength(MinimizePaths(config)) then
      Error("Length differs!!!");
    fi;
    result := OnListByPos(config,
                      BuildByWord(w,CircularTranspositions(n),(),\*));
    if not (result in targets) then Error("Missed target!!!");fi;
  od;
end;


CheckCircularGeodesics := function(l)
local n, targets, result,minreps,i,w,D;
  n := Size(l);
  D := DihedralGroup(IsPermGroup,2*n);
  targets := List(D, g -> OnListByPos([1..n],g));
  minreps := MinimalReps(l);
  for i in [1..Size(minreps.configs)] do
    w := Circular2InvSort(minreps.configs[i]);
    if Size(w) <> minreps.length then
      Error("Length differs!!!");
    fi;
    result := OnListByPos(minreps.configs[i],
                      BuildByWord(w,CircularTranspositions(n),(),\*));
    if not (result in targets) then Error("Missed target!!!");fi;
  od;
end;

################################################################################
# SIGNED LENGTH ################################################################
CircularSignedTwoInversionsLength := function(sp,n)
  local w,length,gens,l,rl;
  l := MinimalReps(ForgetSignsPaddedList(sp,n)).configs[1];
  Display(l);
  w := Circular2InvSort(l);
  Display(w);
  length := Size(w);
  #now play it
  gens := List(CircularBlocksOfSize(n,2), b->CircularBlock2Inversion(n,b));
  rl := OnTuples(l, BuildByWord(w,gens,One(gens[1]),\*));
  Display(rl);
  return length+Size(Filtered(rl, x->x<0));
end;
