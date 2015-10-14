# mt - multiplication table of group
MaxDiam := function(mt)
  local iss, gens, Gs, diams, max;
  iss := IS(mt,ISCanCons);
  Remove(iss, Position(iss, EmptySet(mt)));
  gens := List(iss, x->SetByIndicatorFunction(x, SortedElements(mt)));
  Gs := Filtered(List(gens,Group), x-> Size(x) = Size(mt));
  diams := List(Gs, x->Diam(x));
  max := Maximum(diams);
  return [max, List(Gs{Positions(diams,max)}, GeneratorsOfGroup)];
end;

S5 := SymmetricGroup(IsPermGroup,5);
Print(MaxDiam(MulTab(S5,S5)));
