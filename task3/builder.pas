{$H+}{$I-}
unit builder;


interface

uses multiply;

function longword_to_string(k : longword) : string;

procedure specify_relationships_altern2(var file_ind, f : text; var p_tree: tree);

procedure specify_relationships_altern1(var file_ind : text; min, max : longword);

{procedure specify_relationships_altern(var file_ind : text; min, max : longword);}

procedure add_number(var file_ind : text; var k : longword);

procedure specify_relationships(var file_ind : text; min, max : longword; b : boolean);

procedure tree_node_to_graph(var main_tree: tree; var file_ind : text);

implementation


{procedure metrika_to_num(p_tree: tree, l : longword)
var	
	k : longword;
begin
	k:= l;
	if p_tree^.left <> nil then 
		k := 
end;}



function longword_to_string(k : longword) : string;
var
	s : string;
begin
	s := '';
	while k > 0 do
	begin
		s := chr((k mod 10) + ord('0')) + s;
		k := k div 10;
	end;
	longword_to_string := s;
end;

{procedure specify_relationships(var file_ind : text, cardinality : longword);
var 
	k : longword;
begin
	for k := 1 to cardinality
	WriteLn(file_ind, cardinality div 2, ' -> ', (cardinality div 2) -1, ' [label="L"];')
end;}





procedure specify_relationships(var file_ind : text; min, max : longword; b : boolean);

begin
	if b and (max - min <> 1) then
	begin
		if ((min + max) div 2) - 1 >= min then 
		begin
			WriteLn(file_ind, (min + max) div 2, ' -> ', ((min + max) div 2) - 1, ' [label="L"];');
			specify_relationships(file_ind, min, ((min + max) div 2) - 1, true);
			specify_relationships(file_ind, (min + max) div 2 + 1, max, false);
		end;
		if ((min + max) div 2) + 1 <= max then
		begin
			WriteLn(file_ind, (min + max) div 2, ' -> ', ((min + max) div 2) + 1, ' [label="R"];');
			specify_relationships(file_ind, (min + max) div 2, ((min + max) div 2) - 1, true);
			specify_relationships(file_ind, (min + max) div 2 + 2, max, false);
		end;
	end;
	if (not b) and (max - min > 2) then
	begin
		if ((min + max) div 2) - 1 >= min then 
		begin
			WriteLn(file_ind, (min + max) div 2, ' -> ', ((min + max) div 2) - 1, ' [label="L"];');
			specify_relationships(file_ind, min, ((min + max) div 2) - 1, true);
			specify_relationships(file_ind, (min + max) div 2 + 2, max, false);
		end;
		if ((min + max) div 2) + 1 <= max then
		begin
			WriteLn(file_ind, (min + max) div 2, ' -> ', ((min + max) div 2) + 1, ' [label="R"];');
			specify_relationships(file_ind, min, ((min + max) div 2) - 1, true);
			specify_relationships(file_ind, (min + max) div 2 + 3, max, false);
		end;	
	end;
	if (not b) and (max - min = 2) then
	begin
		WriteLn(file_ind, (min + max) div 2, ' -> ', (min + max) div 2 + 1, ' [label="R"];');
	end;
		
end;

{procedure to_degree(koeff : longword);
var	
	k : longword;
	
begin
	k := 1; 
	if k < koeff then
		
end;}

procedure specify_relationships_altern1(var file_ind : text; min, max : longword);
var 
	n : longword;

begin
	if max - min = 2 then
	begin
		WriteLn(file_ind, (max + min) div 2, ' -> ', min, ' [label="L"];');
		WriteLn(file_ind, (max + min) div 2, ' -> ', max, ' [label="R"];');
	end
	else if max - min > 2 then
	begin
		n := round(exp(ln(2.0)*(round(ln(max - min + 1) / ln(2.0) - 1))));
		
		WriteLn(file_ind, min + n - 1, ' -> ', min + n - 1 - n div 2, ' [label="L"];');
		specify_relationships_altern1(file_ind, min, min + n - 2);
		WriteLn(file_ind, min + n - 1, ' -> ', min + n - 1 + n div 2, ' [label="L"];');
		specify_relationships_altern1(file_ind, min + n, max);
	end;
end;

procedure specify_relationships_altern2(var file_ind, f : text; var p_tree: tree);

begin
	if p_tree^.left <> nil then 
	begin
		WriteLn(f, p_tree^.metrika, ' -> ', p_tree^.left^.metrika, ' [label="L"];');
		specify_relationships_altern2(file_ind, f, p_tree^.left);
	end;
	if p_tree^.right <> nil then 
	begin
		WriteLn(f, p_tree^.metrika, ' -> ', p_tree^.right^.metrika, ' [label="R"];');
		specify_relationships_altern2(file_ind, f, p_tree^.right);
	end;
end;


{procedure specify_relationships_altern(var file_ind : text; min, max : longword);
var		
	n, i, koeff : longword;

begin
	n := 0;
	if max - min > 1 then
	begin
		n := 1;
		for i := 1 to Trunc(ln(max - min)/ln(2.0)) do
			n := n * 2;
	end;
	
	if n = 1 then
	begin
		WriteLn(file_ind, (max + min) div 2, ' -> ', min, ' [label="L"];');
		WriteLn(file_ind, (max + min) div 2, ' -> ', max, ' [label="R"];');
	end
	else if n > 1 then
	begin
		koeff := max;
		to_degree(koeff);
		WriteLn(file_ind, min + n - 1, ' -> ', min + Trunc(n / 2) - 1, ' [label="L"];');
		specify_relationships_altern(file_ind, min, koeff - n);
		WriteLn(file_ind, min + n - 1, ' -> ', min + Trunc(3 * n / 2) - 1, ' [label="R"];');
		specify_relationships_altern(file_ind, min + n, max);
	end;
end;}




procedure add_number(var file_ind : text; var k : longword);
var 
	f : text;
	s : string;
	i : longword;
	
begin
    k := 0;
	Reset(file_ind);
	Assign(f, 'jdor875GHYD65uoh74dl');
	ReWrite(f);
	while not eof(file_ind) do
	begin
		ReadLn(file_ind, s);
		WriteLn(f, s);
	end;
	Close(f);
	Reset(f);
	ReWrite(file_ind);
	while not eof(f) do
	begin
		ReadLn(f, s);
		if s[1] = '[' then
		begin
			k := k + 1;
			for i := Trunc(ln(k) / ln(10.0)) to 5 do
				s := ' ' + s;
			s := longword_to_string(k) + s;
		end;
		WriteLn(file_ind, s);
	end;
	Close(f);
	Erase(f);
	
end;

procedure tree_node_to_graph(var main_tree: tree; var file_ind : text);
var 
	temp_tree : tree;
	i : integer;
	
begin
	if main_tree^.left <> nil then 
		tree_node_to_graph(main_tree^.left, file_ind);
		
	Write(file_ind, '[label="', main_tree^.row);
	for i := Trunc(ln(main_tree^.row) / ln(10)) + Trunc(ln(main_tree^.column) / ln(10.0)) to 8 do
		Write(file_ind, ' ');
	Write(file_ind, main_tree^.column, '\n', main_tree^.value:1:2, '"];');
	WriteLn(file_ind);
	
	if main_tree^.right <> nil then 
		tree_node_to_graph(main_tree^.right, file_ind);
end;

end.