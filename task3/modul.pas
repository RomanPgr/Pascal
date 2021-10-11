{$H+}{$I-}
unit modul;

interface

procedure Show(var f: text);

procedure Generator(var f: text; m, n: longint; r: real);

procedure Generator(var f: text; m, n: longint; r: real; k: longint);

procedure Fsize(var f: text; var m, n: longint);

procedure Error;

function Min(a, b: longint): longint;

procedure Val(s: string; var x: longint; var err: longint);

function Verif(var s: string): boolean;

implementation

procedure Fsize(var f: text; var m, n: longint);
var
  s: string;
  k, i: longint;
  c: char;

begin
  Reset(f);
  k := 1;
  while not eof(f) do
  begin
    ReadLn(f, s);
    if s[1] + s[2] + s[3] + s[4] + s[5] + s[6] = 'matrix' then
      break;
    k := k + 1
  end;
  Reset(f);
  for i := 1 to k - 1 do
    ReadLn(f);
  for i := 1 to 6 do
    Read(f, c);
  Read(f, m, n);
end;





procedure Show(var f: text);
var
    m, n, i, j, a, b, c, d: longint;
    x: real;
begin
	Fsize(f, m, n);
	WriteLn(#10, 'matrix ',m,' ',n);
	if not eoln(f) then 
		ReadLn(f);
    i := 1;
	j := 0;
	while not eof(f) do
	begin
		ReadLn(f, a, b, x);
		if IoResult=0 then 
		begin
			if i < a then 
			begin
				for d := j to n - 1 do
					Write('0 ');
				for c := i to a - 2 do
				begin
					WriteLn();
					for d := 1 to n do
						Write('0 ');
				end;
				if i < a then 
					WriteLn();
				for d := 1 to b - 1 do
					Write('0 ');
			end
			else
				for d := j to b - 2 do
					Write('0 ');
			Write(x:10:3, ' ');
			i := a;
			j := b;
		end;
	end;
	
	if i < m then
	begin
		for d := j to n - 1 do
			Write('0 ');
		for c := i to m - 1 do
		begin
			WriteLn();
			for d := 1 to n do
				Write('0 ');
		end;
	end
	else
		for d := j to n-1 do
			Write('0 ');
	Close(f);
end;








procedure Generator(var f: text; m, n: longint; r: real);
const
  MAXLONG = 2147483647;
var
  i, j: longint;
begin
    ReWrite(f);
	randomize;
    WriteLn(f, 'matrix ', m, ' ', n);
    for i := 1 to m do
        for j := 1 to n do
            if Random(MAXLONG) < (MAXLONG * r) then
                WriteLn(f, i, ' ', j, ' ', Random(MAXLONG) / 100000.0);
    Close(f);
end;

procedure Generator(var f: text; m, n: longint; r: real; k: longint);
const
    MAXLONG = 2147483647;
var
    i, j: longint;
begin
    ReWrite(f);
	randomize;
    WriteLn(f, 'matrix ', m, ' ', n);
    for i := 1 to m do
        for j := 1 to n do
            if Random(MAXLONG) < (MAXLONG * r) then
                WriteLn(f, i, ' ', j, ' ', 1);
    Close(f);
end;

function Verif(var s: string): boolean;
var{Проверяет допустимость имени файла и дописывает разрешение}
  i, l: longint;
begin
  l := Length(s);
  if (l > 0) and (l <= 256) and (s[1] <> '.') then
    for i := 1 to l do 
    begin
      if not (s[i] in (['A'..'Z'] + ['a'..'z'] +
         ['0'..'9'] + ['_', '-', '!', '(', ')', '`', '~', '@', '#', '$',
         ';', '%', ' ', '^', '&', '+', '='])) then
        if (s[i] = '.') and ((l - i) = 3) and 
           (s[i + 1] + s[i + 2] + s[i + 3] = 'txt') then
        begin
          Verif := true;
          Exit
        end
        else
        begin
          Verif := false;
          Exit
        end;
    end
  else
  begin
    Verif := false;
    Exit
  end;
  if l > 252 then
    Verif := false
  else 
    s := s + '.txt';
  Verif := true
end;

procedure Error;
begin
  WriteLn('Error!');
  ReadLn();
  ReadLn();
  halt
end;

procedure Val(s: string; var x: longint; var err: longint);
var{Процедура преобразовывает текст в число longint}
  i, k, c, l: integer;
begin
  x := 0;
  k := 1;
  err := 0;
  l := Length(s);
  if l = 0 then
  begin
    err := 1;
    Exit
  end;
  if s[1] = '-' then
    k := -2;
  if s[1] = '+' then
    k := 2;
  if ((k <> 1) and (l = 1)) then
  begin
    err := 1;
    Exit
  end;
  for i := Abs(k) to l do
    if s[i] in ['0'..'9'] then
    begin
      c := (Ord(s[i]) - Ord('0'));
      if x < 214748364 then
        x := x * 10 + c
      else if x = 214748364 then 
        if k > 0 then
          if (c < 8) and (i = l) then
          begin
            x := x * 10 - Ord('0') + Ord(s[i]);
            Exit;
          end
          else 
          begin
            err := 1;
            Exit
          end
        else
        if (c <= 8) and (i = l) then
        begin
          x := (-x) * 10 - c;
          Exit
        end
        else
        begin
          err := 1;
          Exit
        end
      else
      begin
        err := 1;
        Exit
      end
    end
    else
    begin
      err := 1;
      Exit
    end;
  if k < 0 then
    x := -x
end;

function Min(a, b: longint): longint;
begin
  if a > b then 
    Min := b
  else
    Min := a;
end;
end.
