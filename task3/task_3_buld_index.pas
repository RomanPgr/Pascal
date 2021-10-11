{$H+}{$I-}
uses multiply, modul, builder;



var 
	main_tree, temp_node_tr : tree;
	name_file_matr, name_file_ind, new_name : string;
	file_matr, file_ind, f_temp : text;
	i, j : longword;
	x : double;
	not_empty : boolean;
	number, cardinality, counter : longword;
	s: string;
	
{procedure tree_node_to_graph_exp(var main_tree: tree; var file_ind : text);
var 
	temp_tree : tree;
	i : integer;
	s : string;
	
begin
	if main_tree^.left <> nil then 
		tree_node_to_graph_exp(main_tree^.left, file_ind);
		
	for i := Trunc(ln(number) / ln(10.0)) to 5 do
		s := ' ' + s;
	s := longword_to_string(number) + s;
	Write(file_ind, s);
	Write(file_ind, '[label="', main_tree^.row);
	for i := Trunc(ln(main_tree^.row) / ln(10.0)) + Trunc(ln(main_tree^.column) / ln(10.0)) to 8 do
		Write(file_ind, ' ');
	Write(file_ind, main_tree^.column, '\n', main_tree^.value:1:2, '"];');
	WriteLn(file_ind);
	
	if main_tree^.right <> nil then 
		tree_node_to_graph_exp(main_tree^.right, file_ind);
	number := number + 1;
end;}
	
begin
	number := 1;
	Write('Enter a name for the matrix file: ');
	ReadLn(name_file_matr);
	if not Verif(name_file_matr) then
		Error;
		
	Assign(file_matr, name_file_matr);
	Reset(file_matr);
	if (IoResult <> 0) or (name_file_matr = name_file_ind) then
		Error;
		
	Write('Enter a name to save the matrix index: ');
	ReadLn(name_file_ind);
	if not Verif(name_file_ind) then
		Error;
		
	Assign(file_ind, name_file_ind);
	ReWrite(file_ind);
	
	new(main_tree);
	not_empty := false;
	new(temp_node_tr);
	temp_node_tr := main_tree;
	counter := 0;
	
	while not eof(file_matr) do
	begin
		ReadLn(file_matr, i, j, x);
		if IoResult = 0 then
		begin
			not_empty := true;
			{temp_node_tr^.metrika := 65000 * i + j;}
			counter := counter + 1;
			temp_node_tr^.metrika := counter;
			
			temp_node_tr^.row := i;
			temp_node_tr^.column := j;
			temp_node_tr^.value := x;
			if not eof(file_matr) then
			begin
			new(temp_node_tr^.right);
			temp_node_tr := temp_node_tr^.right;
			end;
		end
		else
			if not eoln(file_matr) then
				ReadLn(file_matr);
	end;
	
	tree_to_list(main_tree);
	balance_tree(main_tree);
	
	WriteLn(file_ind, 'digraph');
	WriteLn(file_ind, '{');
	
	if not_empty then
	begin
		tree_node_to_graph(main_tree, file_ind);
		add_number(file_ind, cardinality);
	end;
	
	
	Close(file_ind);
	Append(file_ind);
	
	
	WriteLn(file_ind, '//edges');
	
	
	Close(file_ind);
	Append(file_ind);
	
	
	{specify_relationships_altern1(file_ind, 1, cardinality);}
	
	{specify_relationships(file_ind, 1, cardinality, true);}
	
	Assign(f_temp, 'jer843ugfw3U4387USur743gia');
	ReWrite(f_temp);
	
	specify_relationships_altern2(file_ind, f_temp, main_tree);
	
	
	Close(f_temp);
	Reset(f_temp);
	Close(file_ind);
	Append(file_ind);
	
	while not eof(f_temp) do
	begin
		ReadLn(f_temp, s);
		WriteLn(file_ind, s);
	end;
	
	Close(f_temp);
	Erase(f_temp);
	
	
	WriteLn(file_ind, '}');
	
	new_name := '';
	
	for counter := 1 to Length(name_file_ind) do
	begin
		if name_file_ind[counter] = '.' then
			break;
		new_name := new_name + name_file_ind[counter];
	end;
	
	new_name := new_name + '.dot';
	
	Close(file_ind);
	
	rename(file_ind, new_name);
	
	
end.