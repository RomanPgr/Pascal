{$H+}{$I-}
uses multiply, modul;
{
type
	tree_node = record
					metrika: longint;
					row, column: longint;
					value: double;
					left, right: ^tree_node;
				end;
				
	tree = ^tree_node;
}	
var
	p_mnoz1, p_mnoz2, list, vrem, p_res, p_temp_parent, p_temp_current : tree;
	f1, f2, f_res : text;
	s : string;
	i, j, m1, n1, m2, n2 :longint;
	x: real;
	b : boolean;
	
begin
    Write('Enter the file name of the first matrix: ');
	ReadLn(s);
	if not Verif(s) then
		Error;
	Assign(f1, s);
	Reset(f1);
	if IoResult <> 0 then
		Error;
	
	Write('Enter a file name with the second matrix: ');
	ReadLn(s);
	if not Verif(s) then
		Error;
	Assign(f2, s);
	Reset(f2);
	if IoResult <> 0 then
		Error;
		
	Write('Enter a file name for the resulting matrix: ');
	ReadLn(s);
	if not Verif(s) then
		Error;
		
	Fsize(f1, m1, n1);
	Reset(f1);
	Fsize(f2, m2, n2);
	Reset(f2);
	
	if n1 <> m2 then	
		Error;
		
	b:= true;	
	p_mnoz1 := nil;
	vrem := nil;
	while not eof(f1) do
	begin
		Read(f1, i, j, x);
		if IoResult <> 0 then
		begin
			if not eoln(f1) then
				ReadLn(f1);
		end
		else
		begin
			new(vrem);
			vrem^.metrika := i * 65001 + j;
			vrem^.row := i;
			vrem^.column := j;
			vrem^.value := x;
			vrem^.left := nil;
			vrem^.right := nil;
				
			if p_mnoz1 = nil then
			begin
				p_mnoz1 := vrem;
			end
			else
			begin
				p_temp_parent := nil;
				p_temp_current := p_mnoz1;
				if find_place(vrem^.metrika, p_mnoz1, p_temp_current, p_temp_parent) then
				begin
					p_temp_current^.value := p_temp_current^.value + vrem^.value;
				end
				else
				begin
					if vrem^.metrika < p_temp_parent^.metrika then
						p_temp_parent^.left := vrem
					else
						p_temp_parent^.right := vrem;
				end
			end
		end;
	end;
		
		
	b:= true;
	p_mnoz2 := nil;
	vrem := nil;
	while not eof(f2) do
	begin
		Read(f2, i, j, x);
		if IoResult <> 0 then
		begin
			if not eoln(f2) then
				ReadLn(f2);
		end
		else
		begin
			new(vrem);
			vrem^.metrika := i * 65001 + j;
			vrem^.row := i;
			vrem^.column := j;
			vrem^.value := x;
			vrem^.left := nil;
			vrem^.right := nil;
				
			if p_mnoz2 = nil then
			begin
				p_mnoz2 := vrem;
			end
			else
			begin
				p_temp_parent := nil;
				p_temp_current := p_mnoz2;
				if find_place(vrem^.metrika, p_mnoz2, p_temp_current, p_temp_parent) then
				begin
					p_temp_current^.value := p_temp_current^.value + vrem^.value;
				end
				else
				begin
					if vrem^.metrika < p_temp_parent^.metrika then
						p_temp_parent^.left := vrem
					else
						p_temp_parent^.right := vrem;
				end
			end
		end
	end;
	
	tree_multiply(p_res, p_mnoz1, p_mnoz2);
		
	tree_to_list(p_res);
	balance_tree(p_res);

	vrem := nil;	
	
	Assign(f_res, s);
	ReWrite(f_res);
	WriteLn(f_res, 'matrix ', m1, ' ', n2);
	
	PrintLeftToRight(f_res, p_res);
	
	Close(f_res);
end.
