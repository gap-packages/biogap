# n - degree
MaxDiam := function(n)
  local Sn, mt, iss, gens, Sns;
  Sn := SymmetricGroup(IsPermGroup, n);
  mt := MulTab(Sn,Sn);
  iss := IS(mt,ISCanCons);
  Remove(iss, Position(iss, EmptySet(mt)));
  gens := List(iss, x->SetByIndicatorFunction(x, SortedElements(mt)));
  Sns := Filtered(List(gens,Group), x-> Size(x) = Size(Sn));
  return List(Sns, x->Diam(x));
end;
