S4 := Group(LinearTranspositions(4));
nontrivelts := Difference(AsSet(S4),[()]);
for pair in Combinations(nontrivelts, 2) do
  Print("triangle:", (), " ", pair[1], " ", pair[2], "  interior:");
  interior := Interior((),pair[1], pair[2], S4); 
  Print(interior, " size:", Size(interior),"\n");
od;
