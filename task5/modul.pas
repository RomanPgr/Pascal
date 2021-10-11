unit modul;

interface

type
	mas_long = array of longint;
	mas_doub = array of double;
	TF = function (x : longint) : double;
	
const
	Two_in_15 = 32768; {2^15}
	
procedure Crossing(F : TF; var x : mas_long; var y : mas_doub; N, 
					Num_cross, modification : longint);

procedure Mutation(F : TF; var x : mas_long; var y : mas_doub; N, 
					Num_mut, modification : longint);

procedure Sort_two_array(var x : mas_long; var y : mas_doub; N : longint);

implementation

procedure Crossing(F : TF; var x : mas_long; var y : mas_doub; N, Num_cross, 
					modification : longint);
	procedure Pod_cross1(var a, b : longint);
	var 
		t, q : longint;
	begin
		if a < b then
		begin
			q := b;
			b := a;
			a := q
		end;
		t := Round(Exp(Random(Trunc(ln(a) / ln(2))) * ln(2)));
		if ((a and t) <> 0) xor ((b and t) <> 0) then
		begin
			a := a xor t;
			b := b xor t
		end
	end;
	procedure Pod_cross2(var a, b : longint);
	begin
		Pod_cross1(a, b);
		Pod_cross1(a, b)
	end;
	procedure Pod_cross3(var a, b : longint);
	var 
		i, x, y : longint;
	begin
		i := 1;
		x := 0;
		y := 0;
		while i < 65536 do
		begin
			if odd(Random(2)) then
				x := x or (a and i)
			else
				y := y or (b and i);
			i := i * 2
		end
	end;
	procedure Pod_cross4(var a, b : longint);
	var
		t, i, x, y : longint;
	begin
		x := 0;
		y := 0;
		i := 1;
		t := Random(65535) + 1;
		while i < 65536 do
		begin
			if (t and i) <> 0 then
				x := x or (a and i)
			else
				y := y or (b and i);
			i := i * 2
		end;
		a := x;
		b := y
	end;
var 
	k, i, a, b : longint;
begin
	k := 1;
	while (x[k] <> 0) and (k < N) do
		k := k + 1;
	if x[k] = 0 then
		while (k <= N) and (Num_cross > 0) do
		begin
			i := 0;
			repeat
				i := i + 1;
				a := x[Random(k - 1) + 1];
				b := x[Random(k - 1) + 1];
			until (a <> b) or (i = 1000);
			case modification of
				1 : Pod_cross1(a, b);
				2 : Pod_cross2(a, b);
				3 : Pod_cross3(a, b);
				4 : Pod_cross4(a, b);
			end;
			x[k] := a;
			y[k] := F(x[k]);
			if k < N then
			begin
				x[k + 1] := b;
				y[k + 1] := F(x[k +1]);
				k := k + 1;
				Num_cross := Num_cross - 1
			end;
			k := k + 1;
			Num_cross := Num_cross - 1
		end
end;

procedure Mutation(F : TF; var x : mas_long; var y : mas_doub; N, Num_mut, 
					modification : longint);
	function Pod_mut1(a : longint) : longint;
	begin
		Pod_mut1 := a xor Round(Exp(Random(Trunc(ln(a) / ln(2))) * ln(2)));
	end;
	
	function Pod_mut2(a : longint) : longint;
	begin
		Pod_mut2 := (a xor Round(Exp(Random(Trunc(ln(a) / ln(2))) * ln(2)))) 
					   xor Round(Exp(Random(Trunc(ln(a) / ln(2))) * ln(2)));
	end;
	
	function Pod_mut3(a : longint) : longint;
	var 
		k, i, t, l : longint;
	begin
		k := Random(Trunc(ln(a) / ln(2))) + 1;
		t := Round(Exp((k - 1) * ln(2)));
		l := 1;
		for i := 1 to k div 2 do
		begin
			if ((a and t) <> 0) xor ((a and l) <> 0) then
				a := a xor t xor l;
			l := l * 2;
			t := t div 2
		end;
		Pod_mut3 := a
	end;
var 
	k, a : longint;
begin
	k := 1;
	while (x[k] <> 0) and (k < N) do
		k := k + 1;
	if x[k] = 0 then
		while (k <= N) and (Num_mut > 0) do
		begin
			a := x[Random(k - 1) + 1];
			case modification of 
				1 : x[k] := Pod_mut1(a);
				2 : x[k] := Pod_mut2(a);
				3 : x[k] := Pod_mut3(a);
			end;
			y[k] := F(x[k]);
			k := k + 1;
			Num_mut := Num_mut - 1
		end
end;


procedure Sort_two_array(var x : mas_long; var y : mas_doub; N : longint);
var
	i, j, k, l, tx : longint;
	ty : double;
begin
	l := N;
	k := 2;
	for i := 1 to  N - 1 do
	begin
		for j := N downto k do
			if y[j] > y[j - 1] then
			begin
				l := j;
				tx := x[j];
				ty := y[j];
				x[j] := x[j - 1];
				y[j] := y[j - 1];
				x[j - 1] := tx;
				y[j - 1] := ty
			end;
		if l < N then
			k := l + 1
		else
			Exit
	end
end;
end.
