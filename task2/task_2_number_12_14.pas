{Это задача №12.14 из задачника Пильщикова}{$H+}
var
  m: integer;

function F: integer;
var
  s: string;
  x, e, y: integer;
begin
  ReadLn(s);
  x := -1;
  Val(s, x, e);
  if (e <> 0) or (x < 0) then
  begin
    WriteLn('Incorrect input.');
    halt
  end;
  if x = 0 then
    F := 0
  else
  begin
    y := F();
    if y > x then
      F := y
    else 
      F := x;
  end;
end;

begin
  m := F;
  if m = 0 then
  begin
    WriteLn('Incorrect input.');
    halt
  end;
  WriteLn(m);
end.