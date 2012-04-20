########################################################
# Declarations for the signed permutation datatype.    #
# (C) Copyright 2011 Attila Egri-Nagy, Andrew Francis  #
########################################################

DeclareGlobalFunction("SignedPermutation");
DeclareGlobalFunction("AsSignedPermutation");
DeclareGlobalFunction("ImageListOfSignedPerm");
DeclareGlobalFunction("PaddedImageListOfSignedPerm");

#type declarations
DeclareCategory("IsSignedPermutation", IsMultiplicativeElementWithInverse);
DeclareRepresentation( "IsSignedPermutationRep",
                       IsComponentObjectRep ,
                       [ "perm" ] );
SignedPermutationFamily :=  NewFamily( "SignedPermutationFamily",
                                           IsSignedPermutation);
SignedPermutationType := NewType(SignedPermutationFamily,
                                 IsSignedPermutation
                                 and IsSignedPermutationRep);