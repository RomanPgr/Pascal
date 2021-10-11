uses graph, modul;

const
	Eps = 0.001;

var 
	gd, gm, error, i, j : integer;
	a, b, c, s : double;

function F(x : double) : double;
begin
	F := Exp(x * ln(2)) + 1
end;	
function G(x : double) : double;
begin
	G := x * x * x * x * x
end;
function H(x : double) : double;
begin
	H := (1 - x) / 3
end;
	
function Fg(x : integer) : integer;
begin
	Fg := Trunc(-(Exp(x / 80 - 4) * ln(2)) * 60 + 180)
end;
function Gg(x : integer) : integer;
begin
	Gg := Trunc(-(x / 80 - 4) * (x / 80 - 4) * (x / 80 - 4) * (x / 80 - 4) * (x / 80 - 4) * 60 + 240)
end;
function Hg(x : integer) : integer;
begin
	Hg := -Trunc((1 - (x - 320) / 80) / 3 * 60) + 240
end;
	
function Min(x, y, z : integer) : integer;
var 
	m : integer;
begin
	m := x;
	if y < m then 
		m := y;
	if z < m then
		m := z;
	Min := m		
end;
function Middle(x, y, z : integer) : integer;
begin
	if ((x <= z) and (x >= y))or((x <= y) and (x >= z))then
		Middle := x;
	if ((y <= x) and (y >= z))or((y <= z) and (y >= x))then
		Middle := y;
	if ((z <= x) and (z >= y))or((z <= y) and (z >= x))then
		Middle := z
end;

begin
	{Выводим пересечения и площадь}
	a := Root(@F, @H, -6, 6);
	b := Root(@G, @H, -6, 6);
	c := Root(@F, @G, -6, 6);
	s := Abs(Integral(@F, a, c)) - Abs(Integral(@H, a, b)) - Abs(Integral(@G, b, c));
	WriteLn('2^x + 1 = (1 - x) / 3 at the point x = ', a : 1 : Abs(Round(ln(Eps) / ln(10))));
	WriteLn('x^5 = (1 - x) / 3 at the point x = ', b : 1 : Abs(Round(ln(Eps) / ln(10))));
	WriteLn('2^x + 1 = x^5 at the point x = ', c : 1 : Abs(Round(ln(Eps) / ln(10))));
	WriteLn('The area of the curvilinear triangle: ', s : 1 : Abs(Round(ln(Eps) / ln(10))));
	
	gd := VGA; {адаптер VGA}
	gm := VGAHi; {режим 640*480пикс.*16 цветов}
	Initgraph(gd, gm, '');
	error := Graphresult;
	if error <> grOk then begin
		WriteLn('Graphics error: ', Grapherrormsg(error));
		Readln();
		Halt()
	end;
	Setcolor(7);
	for  i := 0 to Getmaxy() do
		Line(0, i, Getmaxx(), i);
	Setcolor(4);	
	for i := 0 to Getmaxx() do
	begin
		Putpixel(i, Fg(i), 14);
		Putpixel(i, Gg(i), 1);
		Putpixel(i, Hg(i), 2);
		Putpixel(i, Fg(i) + 1, 14);
		Putpixel(i, Gg(i) + 1, 1);
		Putpixel(i, Gg(i) - 1, 1);
		Putpixel(i, Hg(i) + 1, 2);
		if (Fg(i) = Min(Fg(i), Gg(i), Hg(i))) and (i < 500) and (i > 148) then
			Line(i, Min(Fg(i) + 1, Gg(i) + 1, Hg(i) + 1) + 1, i, Middle(Fg(i), Gg(i) - 1, Hg(i)) - 1)
	end;
	Setcolor(0);
	Line(319, 0, 319, Getmaxy());
	Line(320, 0, 320, Getmaxy());
	Line(0, 239, Getmaxx(), 239);
	Line(0, 240, Getmaxx(), 240);
	Putpixel(139, 241, 0);
	Putpixel(Round(b * 80 + 320), 241, 0);
	Putpixel(Round(c * 80 + 320), 241, 0);
	Putpixel(139, 242, 0);
	Putpixel(Round(b * 80 + 320), 242, 0);
	Putpixel(Round(c * 80 + 320), 242, 0);
	Outtextxy(139 - 20, 250, '-2.52');
	Outtextxy(Round(b * 80 + 320) - 17, 250, '0.65');
	Outtextxy(Round(c * 80 + 320) - 12, 250, '1.28');
	Readln();
	Closegraph();
end.
