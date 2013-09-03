LoadPackage("biogap");

for i in [2..4] do
  d := Distances(Group(LinearTranspositions(i)));
  filename := Concatenation("linear_transpositions_",String(i),".dists");
  WriteAssociativeListToFile(d, filename);
  s := ReversedAssociativeList(d);
  s := TransformValues(s,Size);
  filename := Concatenation("linear_transpositions_",String(i),".sizes");
  WriteAssociativeListToFile(s, filename);  
od;
