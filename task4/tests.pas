uses modul;

function F1(x : double) : double;
begin
	F1 := 2
end;

function F2(x : double) : double;
begin
	F2 := x
end;

function F3(x : double) : double;
begin
	F3 := -2 * x + 3
end;

function F4(x : double) : double;
begin
	F4 := (x + 3) * (x - 14)
end;

function F5(x : double) : double;
begin
	F5 := Exp(x)
end;

function F6(x : double) : double;
begin
	F6 := cos(x) + x - 2
end;


begin
	WriteLn('-2x + 3 = e^x at the point:', #10, 'Correct vaiue = 0.5942049585087717486803228', #10, 'Obtained value = ', Root(@F3, @F5, -10, 10) : 1 : 14, #10);
	WriteLn('(x + 3)(x - 14) = cos(x) + x - 2 at the point:', #10, 'Correct vaiue = -2.6666420649380210373454413', #10, 'Obtained value = ', Root(@F4, @F6, -10, 0) : 1 : 14, #10);
	WriteLn('2 = cos(x) + x - 2 at the point:', #10, 'Correct vaiue = 4.3523297067048823432044093', #10, 'Obtained value = ', Root(@F1, @F6, -10, 10) : 1 : 14, #10);
	WriteLn('x = 2 at the point:', #10, 'Correct vaiue = 2', #10, 'Obtained value = ', Root(@F1, @F2, -10, 10) : 1 : 14, #10);

	WriteLn('The integral of x from 3 to 6:', #10, 'Correct vaiue = 13.5', #10, 'Obtained value = ', Integral(@F2, 3, 6) : 1 : 14, #10);
	WriteLn('The integral of e^x from -3 to 4:', #10, 'Correct vaiue = 0.9502129316321360570206576', #10, 'Obtained value = ', Integral(@F5, -3, 0) : 1 : 14, #10);
	WriteLn('The integral of cos(x) + x - 2 from 5 to 10:', #10, 'Correct vaiue = -0.2681774187658144732952751', #10, 'Obtained value = ', Integral(@F6, 2, 3) : 1 : 14, #10);
	
	ReadLn();
end.