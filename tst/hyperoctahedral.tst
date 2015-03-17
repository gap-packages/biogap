################################################################################
## Testing generated hyperoctahedral groups ####################################
################################################################################

gap> START_TEST("biogap package: hyperoctahedral.tst");
gap> LoadPackage("biogap", false);;
gap> f := function(n) return (2^n)*Factorial(n);end;;
gap> ForAll([2..42], x-> Size(Group(List(HyperOctahedralAlgebraicGens(x),
>        AsPermutation))) = f(x));
true
gap> ForAll([1..19], x-> Size(Group(List(HyperOctahedralAllInversionsGens(x),
>        AsPermutation))) = f(x));
true
gap> STOP_TEST("biogap package: hyperoctahedral.tst", 10000);
