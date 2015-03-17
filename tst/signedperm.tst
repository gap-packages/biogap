#############################################################################
## Testing signed permutations


gap> START_TEST("biogap package: signedperm.tst");
gap> LoadPackage("biogap", false);;
gap> s := SignedPermutation([-5,2,-3,-1,4]);
(-1,5,4)(1,-5,-4)(-3,3)
gap> s = AsSignedPermutation(AsPermutation(s));
true
gap> PaddedImageListOfSignedPerm(s,13);
[ -5, 2, -3, -1, 4, 6, 7, 8, 9, 10, 11, 12, 13 ]
gap> HO4 := Group(List(HyperOctahedralAlgebraicGens(4), AsPermutation));;
gap> ForAll(Tuples(HO4,2),
>           p -> p[1]*p[2] = AsPermutation(AsSignedPermutation(p[1])
>                                          *AsSignedPermutation(p[2])));
true
gap> STOP_TEST("biogap package: signedperm.tst", 10000);
