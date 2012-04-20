#############################################################################
## Testing signed permutations


gap> START_TEST("biogap package: signedperm.tst");
gap> LoadPackage("biogap", false);;

gap> s := SignedPermutation([-5,2,-3,-1,4]);
p[ -5, 2, -3, -1, 4 ]
gap> s = AsSignedPermutation(AsPermutation(s));
true
gap> PaddedImageListOfSignedPerm(s,13);
[ -5, 2, -3, -1, 4, 6, 7, 8, 9, 10, 11, 12, 13 ]


gap> STOP_TEST("biogap package: signedperm.tst", 10000);
