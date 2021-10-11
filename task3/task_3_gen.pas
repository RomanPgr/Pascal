{Пусть размеры матрицы не превышают 65 000 х 65 0000}
{$H+}      {$I-}
Uses modul;

type
  flmatr = text;

var
  m, n, i, w: longint;{Размерность матрицы и режим генерации}
  q: real;{Степень разреженности}
  file_name: string;{Имя файла, в который сохранять матрицу}
  s, v: string;
  err: integer;
  f: flmatr;

begin
  Write('Enter the number of rows in the matrix: ');
  ReadLn(m);
  if (IoResult <> 0) or (m < 1) or (m >  65000) then
    Error;
  
  Write('Enter the number of columns in the matrix: ');
  ReadLn(n);
  if (IoResult <> 0) or (n < 1) or (n >  65000) then
    Error;
  
  Write('Enter the sparsity degree of the row in the matrix: ');
  ReadLn(q);
  if (IoResult <> 0) or (q <= 0) or (q > 1) then
    Error;
  
  Write('Enter the generation mode: ');
  ReadLn(w);
  if (IoResult <> 0) or (w < 1) or (w > 3) then
    Error;
  
  Write('Enter the name of the file to which you want to save the matrix: ');
  ReadLn(file_name);
  if not Verif(file_name) then
    Error;
  
  Assign(f, file_name);
	case w of
		1: Generator(f, m, n, q, 1);
		2: Generator(f, m, n, q);
		3: begin
		        ReWrite(f);
				WriteLn(f, 'matrix ', m, ' ', n);
				for i := 1 to Min(m, n) do
					WriteLn(f, i, ' ', i, ' ', '1');
				Close(f)
		   end
  end;
  
 
  Write('Print a dense matrix? (Yes/ No): ');
  ReadLn(v);
  if (v = 'y') or (v = 'Y') or (v = 'yes') or (v = 'YES') or (v = 'Yes') then
    Show(f);
  ReadLn();
end.
