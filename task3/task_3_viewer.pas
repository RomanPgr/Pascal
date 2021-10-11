{$H+}{$I-}
uses modul, multiply;
var 
	file_index : text;
	name_file, stroka : string;
	rezim : integer;
	metrika, err, row, column, i, j, ch, cha, qw, yt : longint;
	counter : longword;
	temp_node_tr, main_tree : tree;
	x : double;
	l : longword;
		
procedure ot_kornya(var main_tree: tree);
begin
	if main_tree^.left <> nil then
		ot_kornya(main_tree^.left);
	
	Write(main_tree^.metrika,' (', main_tree^.row,',',main_tree^.column,') ');
	if main_tree^.left<> nil then 
		Write('L(',main_tree^.left^.metrika,')');
	if main_tree^.right<> nil then 
		Write('R(',main_tree^.right^.metrika,')');
	WriteLn;
	
	if main_tree^.right <> nil then
		ot_kornya(main_tree^.right);
end;

procedure rezim_dva(var main_tree: tree; k,i:longint);
//var	i:longint;
begin
	
	if i < k then
	begin
		i:=i+1;
		if main_tree^.left<> nil then
			rezim_dva(main_tree^.left,k,i);
		if main_tree^.right<> nil then
			rezim_dva(main_tree^.right, k,i);
	end;
	if i = k then
	begin
		Write(main_tree^.metrika, ' (', main_tree^.row,',',main_tree^.column,') ');
		if main_tree^.left<>nil then
			Write('L(', main_tree^.left^.metrika, ') ');
		if main_tree^.right<>nil then
			Write('R(',main_tree^.right^.metrika, ')');
		WriteLn;
	end;
	
end;

begin
	counter := 0;

	Write('Enter the name of the index file: ');
	ReadLn(name_file);
	
	if not Verif(name_file) then
		Error;
	
	Assign(file_index, name_file);
	
	
	Reset(file_index);
	
	
	if  (IoResult <> 0) then
		Error;
		
		
	Write('Select input mode: ');
	ReadLn(rezim);	
	if IoResult <> 0 then
		Error;
		
		
	new(main_tree);
	new(temp_node_tr);
	temp_node_tr := main_tree;
		
	
		
	while not eof(file_index) do
	begin
		ReadLn(file_index, i, j, x);
		if IoResult = 0 then
		begin
			counter := counter + 1;
			temp_node_tr^.metrika := counter;
			temp_node_tr^.row := i;
			temp_node_tr^.column := j;
			temp_node_tr^.value := x;
			if not eof(file_index) then
			begin
				new(temp_node_tr^.right);
				temp_node_tr := temp_node_tr^.right;
			end;
		end
		else
			if not eoln(file_index) then
				ReadLn(file_index);
	end;
	
	tree_to_list(main_tree);
	balance_tree(main_tree);
		
		
	if rezim = 1 then
		ot_kornya(main_tree);
		
		//tree_to_list(main_tree);
		
	if rezim = 2 then 
	
	
	
	begin
		for qw := 1 to 5 do 
		begin
		//ReadLn;
			WriteLn(qw,':');
			rezim_dva(main_tree, qw, 1);
			cha := 0;
			ch := 1;
		end;
	end;
	ReadLn;
end.