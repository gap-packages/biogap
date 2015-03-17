BioGapTestInstall := function()
local test,infolevel;
#  infolevel := InfoLevel(BioGapInfoClass);
#  SetInfoLevel(BioGapInfoClass, 0);
  for test in [
          "signedperm"
          ] do
    Test(Concatenation(
            PackageInfo("biogap")[1]!.InstallationPath,
            "/tst/",test,
            ".tst"));;
  od;
#  SetInfoLevel(BioGapInfoClass, infolevel);
end;
MakeReadOnlyGlobal("BioGapTestInstall");

BioGapTestAll := function()
local test,infolevel;
#  infolevel := InfoLevel(BioGapInfoClass);
#  SetInfoLevel(BioGapInfoClass, 0);
  for test in [
          "hyperoctahedral",
          "signedperm"
          ] do
    Test(Concatenation(
            PackageInfo("biogap")[1]!.InstallationPath,
            "/tst/",test,
            ".tst"));;
  od;
#  SetInfoLevel(BioGapInfoClass, infolevel);
end;
MakeReadOnlyGlobal("BioGapTestAll");
