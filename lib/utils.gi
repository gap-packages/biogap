InstallGlobalFunction(BioGapMakeDoc,
function()
  MakeGAPDocDoc(Concatenation(PackageInfo("biogap")[1]!.
          InstallationPath, "/doc"), "biogap",
          ["../lib/signedperm.xml",
           "../lib/hyperoctahedral.xml",
           "../lib/circularblocks.xml"
           ], "biogap",     "MathJax");;
end);