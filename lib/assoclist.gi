#############################################################################
##
## Associative List (implementation)
##
## Copyright (C)  Attila Egri-Nagy
##

#an empty associative list
InstallOtherMethod(AssociativeList,
        "empty assoclist", true, [],
        function()
  return Objectify(AssociativeListType,
                 rec(keys:=[], values:=[]));
end);

#construct an associative list loaded based on keys and values
InstallMethod(AssociativeList,"for two lists", true, [IsList, IsList],
function(keys, values)
  local al,i,pos;
  #sanity check
  if Size(keys) <> Size(values) then return fail; fi;

  al := AssociativeList();
  Perform([1..Length(keys)], function(x) Assign(al, keys[x], values[x]); end);
  return al;
end);

#mapping keys to their positions
InstallOtherMethod(AssociativeList,
        "for a list mapping elemetns to their positions", true, [IsList],0,
function(keys)
  return AssociativeList(keys,[1..Length(keys)]);
end);

# unfortunately list assignment works only with integrals
# so we need a dedicated assign function
InstallGlobalFunction(Assign,
function(assoclist, key, value)
  local pos;
  pos := Position(assoclist!.keys, key);
    if pos = fail then
      pos := PositionSorted(assoclist!.keys, key);
      Add(assoclist!.keys,key,pos);
      Add(assoclist!.values, value, pos);
    else
        assoclist!.values[pos] := value;
    fi;
end);

InstallGlobalFunction(Collect,
function(assoclist, key, value)
  local pos;
  pos := Position(assoclist!.keys, key);
    if pos = fail then
      pos := PositionSorted(assoclist!.keys, key);
      Add(assoclist!.keys,key,pos);
      Add(assoclist!.values, [value], pos);
    else
        Add(assoclist!.values[pos],value);
    fi;
end);

InstallGlobalFunction(Count,
function(assoclist, key)
  local pos;
  pos := Position(assoclist!.keys, key);
  if pos = fail then
    pos := PositionSorted(assoclist!.keys, key);
    Add(assoclist!.keys,key,pos);
    Add(assoclist!.values, 1, pos);
  else
    assoclist!.values[pos] := assoclist!.values[pos]+1;
  fi;
end);

# TODO: next two functions are invitations for mutability disasters!
#it gives back the keys
InstallGlobalFunction(Keys,
function(assoclist)
    return assoclist!.keys;
end);

InstallGlobalFunction(Values,
function(assoclist)
  return assoclist!.values;
end);

#it gives back the values as a set
InstallGlobalFunction(ValueSet,
function(assoclist)
    return AsSet(assoclist!.values);
end);


#transform the keys according to the given function
InstallGlobalFunction(TransformKeys,
function(assoclist,funct)
local k,al;
  al := AssociativeList();
  Perform(assoclist!.keys,
          function(k)
            Assign(al, funct(k), assoclist[k]);
          end);
  return al;
end);

#transform the values according to the given function
InstallGlobalFunction(TransformValues,
function(assoclist,funct)
local k,al;
  al := AssociativeList();
  Perform(assoclist!.keys,
          function(k)
            Assign(al, k, funct(assoclist[k]));
          end);
  return al;
end);

InstallGlobalFunction(ContainsKey,
function(assoclist,key) return assoclist[key] <> fail; end);

InstallGlobalFunction(Lookup,
function( assoclist, key )
  local pos;
  pos := Position(assoclist!.keys, key);
  if pos <> fail then
    return assoclist!.values[pos];
  else
    return fail;
  fi;
end);

#accessing elements by arbitrary indices
InstallOtherMethod( \[\],
    "for associative lists",
    [ IsAssociativeList, IsObject], Lookup);

#if the keyset is the same then we can combine the values
InstallGlobalFunction(CombinedAssociativeList,
function(l1,l2)
local k, l;
  if Keys(l1) <> Keys(l2) then
      Print("#W Different keysets cannot be combined!\n");
      return fail;
  fi;
  l :=  AssociativeList();
  for k in Keys(l1) do
    Assign(l, k, [l1[k],l2[k]]);
  od;
  return l;
end);

#values -> keys, but obviously list valued
InstallGlobalFunction(ReversedAssociativeList,
function(al)
local nl,k,val,l;
  nl := AssociativeList();
  for k in Keys(al) do
      val := al[k];
      if val in Keys(nl) then
          l := nl[val];
          AddSet(l,k);
      else
          Assign(nl,val,[k]);
      fi;
  od;
  return nl;
end);

#if the keyset is the same then we can combine the values
InstallGlobalFunction(UnionAssociativeList,
function(als)
local k, al,nal;
  nal := AssociativeList();
  for al in als do
    for k in Keys(al) do
      Assign(nal, k, al[k]);
    od;
  od;
  return nal;
end);


InstallOtherMethod(\=, "for two associative lists", IsIdenticalObj,
        [IsAssociativeList,
         IsAssociativeList],
function(A, B)
  return  A!.keys = B!.keys and A!.values = B!.values;
end);

InstallMethod( PrintObj,"for an associative list",
        [ IsAssociativeList ],
function( al )
local key;
  if IsEmpty(Keys(al)) then
    Print("empty associative list");
  else
    for key in Keys(al) do
      Print(key," -> ", al[key],"\n");
    od;
  fi;
end);

InstallGlobalFunction(MaxValueInAssociativeList,
function(al) return Maximum(al!.values); end);

InstallGlobalFunction(WriteAssociativeListToFile,
function(al, filename)
local file,key;
  file := OutputTextFile(filename, false);
  for key in Keys(al) do
    WriteLine(file,
            Concatenation(
                    String(key),
                    ":",
                    String(al[key])));
  od;
  CloseStream(file);
end);
