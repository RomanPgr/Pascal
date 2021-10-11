{$H+}{$I-}
unit modul;

interface

type 
	TF = function (x : double) : double;
const
	Eps = 0.00000000000001;

function Root(f, g : TF; q, w : double) : double;

function Integral(f : TF; a, b : double) : double;

implementation

function Root(F, G : TF; q, w : double) : double;
var
	a, b, c : double;
begin
	a := q;
	b := w;
	While Abs(F(a) - F(b) + G(b) - G(a))  > Eps do
	begin
		c := (b + a) / 2;
		if (F(a) - G(a)) * (F(c) - G(c)) >= 0 then 
			a := c
		else
			b := c
	end;
	Root := (a + b) / 2
end;

function Integral(f : TF; a, b : double) : double;
	function Simpson(n : longint) : double;
	var
		i : longint;
		s, h : double;
	begin
		h := (b - a) / n;
		s := f(a) + f(b);
		for i := 1 to n - 1 do
			if odd(i) then
				s := s + 4 * f(a + i * h)
			else
				s := s + 2 * f(a + i * h);
		Simpson := s * h / 3;
	end;
var 
	i : longint = 8;
	s, s1 : double;
begin
	s := Simpson(2);
	s1 := Simpson(4);
	while Abs(s - s1) > Eps do
	begin
		s := s1;
		s1 := Simpson(i);
		i := i * 2
	end;
	Integral := s1
end;
end.