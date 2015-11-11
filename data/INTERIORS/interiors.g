S4 := Group(LinearTranspositions(4));
#S4 := Group(CircularTranspositions(4));

for triangle in AllTriangles(S4) do
  Print("triangle:", triangle[1], " ", triangle[2], " ", triangle[3], "  interior:");
  interior := Interior(triangle[1],triangle[2], triangle[3], S4); 
  Print(interior, " size:", Size(interior),"\n");
od;

# distribution of intervals
sizes := List(S4, x->Size(Interval((),x,S4)));
Display(Collected(sizes));

# distance between two group elements
df := DistanceFunction(S4);
Display(df((),(1,2)*(3,4)));
