# mt - multiplication table of group
SpeedAnalysis := function(gensets)
  local diams,max,min;
  diams := List(gensets, Diam);
  max := Maximum(diams);
  min := Minimum(diams);
  return rec(max:=max,
             maxgensets := gensets{Positions(diams,max)},
             min := min,
             mingensets := gensets{Positions(diams,min)},
             speeddistribution := Collected(diams));
end;

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
  local Sn, mt, gensets;
  Sn := SymmetricGroup(IsPermGroup,x);
  mt := MulTab(Sn,Sn);
  gensets := List(Filtered(IS(mt,ISCanCons), x->SizeBlist(x)>0),
                  y->SetByIndicatorFunction(y,mt));
  Display(SpeedAnalysis(gensets));
end);
