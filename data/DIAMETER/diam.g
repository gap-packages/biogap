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

Perform([1..5],
function(x)
  local Sn, mt, gensets;
  Sn := SymmetricGroup(IsPermGroup,x);
  mt := MulTab(Sn,Sn);
  gensets := List(Filtered(IS(mt,ISCanCons),
                     x->Size(mt)=SizeBlist(SgpInMulTab(x,mt))),
                  y->SetByIndicatorFunction(y,mt));
  Display(SpeedAnalysis(gensets));
end);
