# mt - multiplication table of group
MaxDiam := function(iss,mt)
  local  gens, Gs, diams, max;
  gens := List(Filtered(iss,y-> SizeBlist(y) > 0),
               x->SetByIndicatorFunction(x, SortedElements(mt)));
  Gs := Filtered(List(gens,Group), x-> Size(x) = Size(mt));
  diams := List(Gs, x->Diam(x));
  max := Maximum(diams);
  return [max, List(Gs{Positions(diams,max)}, GeneratorsOfGroup)];
end;

Perform([1..5],
function(x)
  local Sn, mt;
  Sn := SymmetricGroup(IsPermGroup,x);
  mt := MulTab(Sn,Sn);
  Display(MaxDiam(IS(mt,ISCanCons),mt));
end);
