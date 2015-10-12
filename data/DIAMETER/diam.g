# n - degree
MaxDiam := function(n)
  local Sn, mt, iss, gens, Sns, diams, max;
  Sn := SymmetricGroup(IsPermGroup, n);
  mt := MulTab(Sn,Sn);
  iss := IS(mt,ISCanCons);
  Remove(iss, Position(iss, EmptySet(mt)));
  gens := List(iss, x->SetByIndicatorFunction(x, SortedElements(mt)));
  Sns := Filtered(List(gens,Group), x-> Size(x) = Size(Sn));
  diams := List(Sns, x->Diam(x));
  max := Maximum(diams);
  return [max, List(Sns{Positions(diams,max)}, GeneratorsOfGroup)];
end;
