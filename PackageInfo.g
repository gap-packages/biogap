#############################################################################
##
#W  PackageInfo.g
#Y  Copyright (C) 2011-12                Attila Egri-Nagy, Andrew Francis
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

SetPackageInfo( rec(
PackageName := "biogap",
Subtitle := "Algebraic Tools for Bacterial Genomics",
Version := "0.2.3",
Date := "11/11/2015",
ArchiveURL :=
          "https://bitbucket.org/dersu/biogap",
ArchiveFormats := ".tar.gz",
Persons := [
  rec(
    LastName      := "Egri-Nagy",
    FirstNames    := "Attila",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "a.egri-nagy@uws.edu.au",
    WWWHome       := "http://www.egri-nagy.hu",
    PostalAddress := Concatenation( [
                       "School of Computing, Engineering and Mathematics",
                       " Australia"] ),
    Place         := "Sydney",
    Institution   := "University of Western Sydney"),
  rec(
    LastName      := "Francis",
    FirstNames    := "Andrew",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "a.francis@uws.edu.au",
    WWWHome       := "http://staff.scm.uws.edu.au/~andrew/",
    PostalAddress := Concatenation( [
                       "School of Computing, Engineering and Mathematics",
                       " Australia"] ),
    Place         := "Sydney",
    Institution   := "University of Western Sydney")],
Status := "na",

README_URL :=
  "na",
PackageInfoURL :=
  "na",

AbstractHTML := Concatenation(
  "The <span class=\"pkgname\">biogap</span> package, is a ",
  "<span class=\"pkgname\">GAP</span>  package  for algebraic tools",
  "for bacterial genomics."),

PackageWWWHome := "https://bitbucket.org/dersu/biogap",

PackageDoc := rec(
  BookName  := "biogap",
  Archive :=
      "na",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "biogap - Bacterial Genomics in GAP",
  Autoload  := true
),

Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [["subsemi", ">=0.65"]],
  SuggestedOtherPackages := [["gapdoc", ">=1.5"]],
  ExternalConditions := []),
  AvailabilityTest := ReturnTrue,
  Autoload := false,
  TestFile := "tst/testinstall.tst",
  Keywords := ["bacterial genomics", "signed permutation"]
));
