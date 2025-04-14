#############################################################################
##
#W  PackageInfo.g
#Y  Copyright (C) 2011-17                Attila Egri-Nagy, Andrew Francis
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

SetPackageInfo( rec(
PackageName := "biogap",
Subtitle := "Algebraic Tools for Bacterial Genomics",
Version := "0.3-dev",
Date := "03/08/2017",
ArchiveURL := "https://github.com/gap-packages/biogap/releases",
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
    Place         := "Akita",
    Institution   := "Akita International University"),
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

SourceRepository := rec(
  Type := "git",
  URL := "https://github.com/gap-packages/biogap"
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),

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
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "biogap - Bacterial Genomics in GAP",
),

Dependencies := rec(
  GAP := ">=4.8.7",
  NeededOtherPackages := [["subsemi", ">=0.85"],
                              ["sgpdec", ">=0.8"]],
  SuggestedOtherPackages := [["gapdoc", ">=1.5"]],
  ExternalConditions := []),
  AvailabilityTest := ReturnTrue,
  TestFile := "tst/testinstall.tst",
  Keywords := ["bacterial genomics", "signed permutation"]
));
