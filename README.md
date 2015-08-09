# BioGAP

A GAP4 package for abstract algebraic algorithms in bacterial genomics.
The current implementation contains methods for

* dealing with signed permutations,
* calculating the word distance in different group models,
* computing the graded interval of all geodesics between two group elements.

The GAP system is available from www.gap-system.org. Installing this package is just copying the folder containing 
BioGAP into the pkg/ folder of GAP.

Package dependencies: SgpDec (https://github.com/gap-system/sgpdec),
                      Dust (https://github.com/egri-nagy/dust).

If you use this package in your research please cite BioGAP as:

Attila Egri-Nagy, Andrew R. Francis, Volker Gebhardt,
Bacterial Genomics and Computational Group Theory: The BioGAP Package for GAP,
ICMS 2014, LNCS 8592, pp. 67–74, 2014.

Also, for the 2-inversion model:

Attila Egri-Nagy, Volker Gebhardt, Mark M. Tanaka, Andrew R. Francis:
Group-theoretic models of the inversion process in bacterial genomes,
Journal of Mathematical Biology, Volume 69, Issue 1, pp 243-265, 2014.


You can find the BibTex references in the doc/ folder.
