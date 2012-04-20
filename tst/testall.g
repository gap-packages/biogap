#just going through the testfiles systematically
# borrowed from CITRUS

LoadPackage( "biogap", false );;
dir_str:=Concatenation(PackageInfo("biogap")[1]!.InstallationPath,"/tst");
tst:=DirectoryContents(dir_str);
dir:=Directory(dir_str);
for x in tst do
  str:=SplitString(x, ".");
  if Length(str)>=2 and str[2]="tst" then
    Print("reading ", dir_str,"/", x, " ...\n");
    ReadTest(Filename(dir, x));
    Print("\n");
  fi;
od;
