S4 := SymmetricGroup(IsPermGroup, 4);
nontrivelts := Difference(AsSet(S4),[()]);
for pair in Combinations(nontrivelts, 2) do
  Display(Interior((),pair[1], pair[2], S4));
od;
