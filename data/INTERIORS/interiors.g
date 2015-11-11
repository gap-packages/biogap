S4 := Group(LinearTranspositions(4));

for triangle in AllTriangles(S4) do
  Print("triangle:", triangle[1], " ", triangle[2], " ", triangle[3], "  interior:");
  interior := Interior(triangle[1],triangle[2], triangle[3], S4); 
  Print(interior, " size:", Size(interior),"\n");
od;
