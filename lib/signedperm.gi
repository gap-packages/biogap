########################################################
# Implementation for the signed permutation datatype.  #
# (C) Copyright 2011 Attila Egri-Nagy, Andrew Francis  #
########################################################

################################################
# mapping a  signed integer to an unsigned one
BIOGAP_s2u := function(i)
  if i > 0 then
    return 2*i;
  else
    return 2*AbsInt(i)-1;
  fi;
end;

################################################
# mapping an unsigned integer to a signed one
BIOGAP_u2s := function(k)
  return Int((k+1)/2)*((-1)^(k mod 2));
end;


########################################################
InstallGlobalFunction(SignedPermutation,#"for lists", true,[IsList],0,
function(signedpermlist)
local l,n,i;
  n := Length(signedpermlist);
  #allocating list for the unsigned permutation
  l := [1..2*n];
  for i in [1..n] do
    # code the point and the image
    l[BIOGAP_s2u(i)] := BIOGAP_s2u(signedpermlist[i]);
    # and the same for the inverted pair
    l[BIOGAP_s2u(i*(-1))] := BIOGAP_s2u(signedpermlist[i]*(-1));
  od;
  return Objectify(SignedPermutationType, rec(perm:=PermList(l)));
end
);

#no check is made
InstallGlobalFunction(AsSignedPermutation,
function(perm)
  return Objectify(SignedPermutationType, rec(perm:=perm));
end
);

InstallGlobalFunction(ImageListOfSignedPerm,
function(signedperm)
    local l;
    l := ListPerm(signedperm!.perm);
   return List([1..Length(l)/2], x -> BIOGAP_u2s(l[2*x]) );
end);

InstallGlobalFunction(PaddedImageListOfSignedPerm,
function(signedperm,numofregions)
    local l;
    l := ImageListOfSignedPerm(signedperm);
   return Concatenation(l,[Length(l)+1..numofregions]);
end);


InstallGlobalFunction(ForgetSignsList,
function(sp)
  return List(ImageListOfSignedPerm(sp),x->AbsInt(x));
end);

InstallGlobalFunction(ForgetSignsPaddedList,
function(sp,n)
  return List(PaddedImageListOfSignedPerm(sp,n),x->AbsInt(x));
end);


InstallGlobalFunction(ForgetSignsPerm,
function(sp)
  return PermList(ForgetSignsList(sp));
end);

InstallGlobalFunction(ForgetSignsSignedPerm,
function(sp)
  return SignedPermutation(ForgetSignsList(sp));
end);


###################################################################
# polymorphic methods

InstallOtherMethod(\^, "acting by signed permutations", true,
        [IsInt, IsSignedPermutation], 0,
function(pt,sp)
  return BIOGAP_u2s(BIOGAP_s2u(pt)^(sp!.perm));
end
);


InstallOtherMethod(\<, "ordering of signed permutations", IsIdenticalObj,
        [IsSignedPermutation, IsSignedPermutation], 0,
function(sp,sq)
  return  sp!.perm < sq!.perm;
end
);


InstallOtherMethod(\=, "equality of signed permutations", IsIdenticalObj,
        [IsSignedPermutation, IsSignedPermutation], 0,
function(sp,sq)
  return  sp!.perm = sq!.perm;
end
);


InstallOtherMethod(\*, "multiplying signed permutations", IsIdenticalObj,
        [IsSignedPermutation, IsSignedPermutation], 0,
function(sp,sq)
    #we have to swap the order to get right action (content-duality)
    return  Objectify(SignedPermutationType, rec(perm:=sq!.perm * sp!.perm));
end
);

InstallOtherMethod(OneOp, "neutral element for signed permutations", true,
        [IsSignedPermutation], 0,
function(tmp)
  return SignedPermutation([]);
end
);

InstallOtherMethod(InverseOp, "inverse of a signed permutation", true,
        [IsSignedPermutation], 0,
function(sp)
    return Objectify(SignedPermutationType, rec(perm:=Inverse(sp!.perm)));
end
);

InstallOtherMethod(AsPermutation, "signed permutation as unsigned", true,
        [IsSignedPermutation], 0,
function(sp)
    return sp!.perm;
end
);


###DISPLAY##############
InstallMethod( PrintObj,"for a signed permutation",
    [ IsSignedPermutation ],
function( sp )
  local str, i;
  str := String(AsPermutation(sp));
  
  Print("p");PrintObj(ImageListOfSignedPerm(sp));
end );
