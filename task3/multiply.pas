{$H+}{$I-}
unit multiply;

interface

type 
	tree_node = record
					metrika: longint;  
					row, column: longint;
					value: double;
					left, right: ^tree_node;
				end;
				
	tree = ^tree_node;

procedure PrintLeftToRight(var f_res: text; var p_res: tree);

procedure tree_to_list (var p: tree);

procedure add_to_the_right (var p, ap: tree);

procedure balance_tree (var p: tree);

procedure tree_multiply (var p_res, p_mnoz1, p_mnoz2: tree);

function find_place (el_metr: longint; var p_res, p_cur, p_parent: tree):boolean; 

implementation

procedure PrintLeftToRight(var f_res: text; var p_res: tree);
var left_tree, right_tree: tree;
begin
	if p_res^.left <> nil then
	begin
		left_tree := p_res^.left;
		PrintLeftToRight(f_res, left_tree);
	end;
	WriteLn(f_res, p_res^.row, ' ', p_res^.column, ' ', p_res^.value);
	if p_res^.right <> nil then
	begin
		right_tree := p_res^.right;
		PrintLeftToRight(f_res, right_tree);
	end;
end;

procedure tree_to_list (var p: tree);
var new_head, new_right: tree;
begin
	new_head := nil;
	if p^.left <> nil then
	begin
		new_head := p^.left;
		tree_to_list(new_head);
		p^.left := nil;
	end;
	if p^.right <> nil then
	begin
		new_right := p^.right;
		tree_to_list(new_right);
		p^.right := new_right;
	end;
	if new_head <> nil then
	begin
		add_to_the_right(new_head, p);
		p := new_head;
	end
end;

procedure add_to_the_right (var p, ap: tree);
var elem: tree;
begin
	elem := p;
	while elem^.right <> nil do 
	begin
		elem := elem^.right;
	end;
	elem^.right := ap;
end;

procedure balance_tree (var p: tree);
var p_middle, p_right, p_midanc, new_left, new_right: tree;
	mid: longint;
begin
	mid := 0;
	p_right := p;
	p_middle := p;
	p_midanc := nil;

	while p_right^.right <> nil do
	begin 
		p_right := p_right^.right;
		mid := 1 - mid;
		if mid = 0 then 
		begin
			p_midanc := p_middle;
			p_middle := p_middle^.right;
		end
	end;
	
	if p_midanc <> nil then
	begin
		new_left := p;
		new_right := p_middle^.right;
		p_midanc^.right := nil;
		p_middle^.right := nil;
		balance_tree(new_left);
		p_middle^.left := new_left;
		balance_tree(new_right);
		p_middle^.right := new_right;
		p := p_middle;
	end	
end;

procedure tree_multiply (var p_res, p_mnoz1, p_mnoz2: tree);
var 
	p_elem_mnoz1, p_elem_mnoz2, p_elem_res, p_temp_parent, p_temp_current: tree;
	zero_result: integer;
begin
	new(p_elem_mnoz1);
	p_elem_mnoz1^.metrika := p_mnoz1^.metrika;
	p_elem_mnoz1^.row := p_mnoz1^.row;
	p_elem_mnoz1^.column := p_mnoz1^.column;
	p_elem_mnoz1^.value := p_mnoz1^.value;
	p_elem_mnoz1^.left := nil;
	p_elem_mnoz1^.right := nil;

	new(p_elem_mnoz2);
	p_elem_mnoz2^.metrika := p_mnoz2^.metrika;
	p_elem_mnoz2^.row := p_mnoz2^.row;
	p_elem_mnoz2^.column := p_mnoz2^.column;
	p_elem_mnoz2^.value := p_mnoz2^.value;
	p_elem_mnoz2^.left := nil;
	p_elem_mnoz2^.right := nil;
	
	zero_result := 0;
	if p_elem_mnoz1^.column = p_elem_mnoz2^.row then
	begin
		new(p_elem_res);
		p_elem_res^.metrika := p_elem_mnoz1^.row * 65001 + p_elem_mnoz2^.column;
		p_elem_res^.row := p_elem_mnoz1^.row;
		p_elem_res^.column := p_elem_mnoz2^.column;
		p_elem_res^.value := p_elem_mnoz1^.value * p_elem_mnoz2^.value;
		p_elem_res^.left := nil;
		p_elem_res^.right := nil;

		if p_elem_res^.value <> 0 then 
			zero_result := 1;
	end;
	
	if zero_result <> 0 then
	begin
		if p_res = nil then
		begin
			p_res := p_elem_res; 
		end
		else
		begin
			p_temp_parent := nil;
			p_temp_current := p_res;
			if find_place(p_elem_res^.metrika, p_res, p_temp_current, p_temp_parent) then
			begin
				p_temp_current^.value := p_temp_current^.value + p_elem_res^.value;
			end
			else
			begin
				if p_elem_res^.metrika < p_temp_parent^.metrika then
					p_temp_parent^.left := p_elem_res
				else 
					p_temp_parent^.right := p_elem_res;
			end
		end
	end;

	if p_mnoz2^.left <> nil then
	begin
		tree_multiply(p_res, p_elem_mnoz1, p_mnoz2^.left);
	end;
	if p_mnoz2^.right <> nil then
	begin
		tree_multiply(p_res, p_elem_mnoz1, p_mnoz2^.right);
	end;

	if p_mnoz1^.left <> nil then 
	begin 
		tree_multiply(p_res, p_mnoz1^.left, p_elem_mnoz2);

		if p_mnoz2^.left <> nil then
		begin
			tree_multiply(p_res, p_mnoz1^.left, p_mnoz2^.left);
		end;
		if p_mnoz2^.right <> nil then
		begin
			tree_multiply(p_res, p_mnoz1^.left, p_mnoz2^.right);
		end
	end;

	if p_mnoz1^.right <> nil then 
	begin 
		tree_multiply(p_res, p_mnoz1^.right, p_elem_mnoz2);

		if p_mnoz2^.left <> nil then
		begin
			tree_multiply(p_res, p_mnoz1^.right, p_mnoz2^.left);
		end;
		if p_mnoz2^.right <> nil then
		begin
			tree_multiply(p_res, p_mnoz1^.right, p_mnoz2^.right);
		end
	end
end;

function find_place (el_metr: longint; var p_res, p_cur, p_parent: tree):boolean; 
begin 
	p_cur := p_res; 
	while p_cur <> nil 
	do begin 
		if el_metr = p_cur^.metrika then 
		begin
			find_place := true; 
			Exit; 
		end; 
		p_parent := p_cur; 
		if el_metr < p_cur^.metrika then
			p_cur := p_cur^.left 
		else p_cur := p_cur^.right; 
	end; 
	find_place := false; 
end;

end.