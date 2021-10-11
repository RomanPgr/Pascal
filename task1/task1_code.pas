{Символ новой строки имеет номер 10?
Всё после второй точки не учитывается
Перевод коретки #13 не учитывается}
{$H+}
function Geni(s: string): char;{Преобразует ген в белок}
var
  v: char;
begin
  case s of
    'AAA': v := 'K';
    'AAC': v := 'N';
    'AAG': v := 'K';
    'AAU': v := 'N';
    'ACA': v := 'T';
    'ACC': v := 'T';
    'ACG': v := 'T';
    'ACU': v := 'T';
    'AGA': v := 'R';
    'AGC': v := 'S';
    'AGG': v := 'R';
    'AGU': v := 'S';
    'AUA': v := 'I';
    'AUC': v := 'I';
    'AUG': v := 'M'; {START}
    'AUU': v := 'I';
    
    'CAA': v := 'Q';
    'CAC': v := 'H';
    'CAG': v := 'Q';
    'CAU': v := 'H';
    'CCA': v := 'P';
    'CCC': v := 'P';
    'CCG': v := 'P';
    'CCU': v := 'P';
    'CGA': v := 'R';
    'CGC': v := 'R';
    'CGG': v := 'R';
    'CGU': v := 'R';
    'CUA': v := 'L';
    'CUC': v := 'L';
    'CUG': v := 'L';
    'CUU': v := 'L';
    
    'GAA': v := 'E';
    'GAC': v := 'D';
    'GAG': v := 'E';
    'GAU': v := 'D';
    'GCA': v := 'A';
    'GCC': v := 'A';
    'GCG': v := 'A';
    'GCU': v := 'A';
    'GGA': v := 'G';
    'GGC': v := 'G';
    'GGG': v := 'G';
    'GGU': v := 'G';
    'GUA': v := 'V';
    'GUC': v := 'V';
    'GUG': v := 'V';
    'GUU': v := 'V';
    
    'UAA': v := '7';{STOP}
    'UAC': v := 'Y';
    'UAG': v := '7';{STOP}
    'UAU': v := 'Y';
    'UCA': v := 'S';
    'UCC': v := 'S';
    'UCG': v := 'S';
    'UCU': v := 'S';
    'UGA': v := '7';{STOP}
    'UGC': v := 'C';
    'UGG': v := 'W';
    'UGU': v := 'C';
    'UUA': v := 'L';
    'UUC': v := 'F';
    'UUG': v := 'L';
    'UUU': v := 'F';
  end;
  Geni := v;
end;

var
  s1, s2, s1a, ne_sod: String;
  c: Char;
  i, j, k, nach, kon, nach1, kon1, nach_str, kon_str: Integer;
  bool, t: Boolean;{Истина если ввод ошибочен}

begin
  i := 0;
  t := true;
  s1 := '';
  s2 := '';
  s1a := '';
  kon := 0;
  kon1 := 0;
  bool := false;
  nach := 0;
  nach1 := 0;
  ne_sod := 'RNA does not contain this protein.';
  kon_str := 1;
  nach_str := 1;
  
  
  repeat{Ввод последовательности РНК}
    Read(c);
    if c = #13 then
      continue;
    if c = '.' then
      break;
    if c = #10 then
    begin
      s1 := s1 + '4';
    end
      else
    begin
      if not bool and (i < 10000) then
      begin
        s1 := s1 + c;
        i := i + 1;
        case c of {Ввод только букв в переменную s1a}
          'A', 'a': s1a := s1a + 'A';
          'U', 'u': s1a := s1a + 'U';
          'G', 'g': s1a := s1a + 'G';
          'C', 'c': s1a := s1a + 'C';
        end;
      end
      else
        bool := true;
      if not (c in ['A', 'a', 'U', 'u', 'G', 'g', 'C', 'c', '-', ' ', #10]) then
        bool := true;
    end;
  until false;
  
  i := 0;
  Read(c);
  {Убрать ненужные символы #10 и #13}
  if(c = #10) or (c = #13) then
    Read(c);
  if(c = #10) or (c = #13) then
    Read(c);
  
  repeat{Ввод белка}
    if c = #13 then
    begin
      Read(c);
      continue;
    end;
    if c = '.' then
      break;
    if not bool and (i < 500) then
    begin
      i := i + 1;
      if not (c in ['-', ' ', #10]) then{если с не бесполезный символ}
        s2 := s2 + c;
    end
    else
      bool := true;
    if not (c in ['A', 'R', 'N', 'D', 'C', 'E', 'Q', 'G', 'H', 'I', 'L', 'K',
                  'M', 'F', 'P', 'S', 'T', 'W', 'Y', 'V', '-', ' ', #10]) then
      bool := true;
    Read(c);
  until false;
  
  if (Length(s2) = 0) or (s2[1] <> 'M') then 
    bool := true;  
  
  if bool then {Если был некорректный ввод, то}
  begin
    writeln('Invalid input!')
  end
  
  else if Length(s1a) < 3 * Length(s2) + 3 then
  begin
    writeln(ne_sod);
  end
  
  else{Поиск того, что нужно вывести}
  begin
    i := 1;
    while (Length(s1a) - i + 1) >= (3 * Length(s2) + 3) do
    begin
      if (s1a[i] + s1a[i + 1] + s1a[i + 2]) = 'AUG' then
      begin
        j := 1;
        k := i;
        while j <= Length(s2) do
        begin
          if s2[j] <> Geni(s1a[k] + s1a[k + 1] + s1a[k + 2]) then
            break;
          j := j + 1;
          k := k + 3;
          if (j > Length(s2)) then
          begin
            if (Geni(s1a[k] + s1a[k + 1] + s1a[k + 2]) = '7') then
            begin
              nach := i;
              kon := k + 2;
              break;
            end;
          end;
        end
      end;
      if nach <> 0 then
        break;
      i := i + 1;
    end;
    
    if nach = 0 then
    begin
      writeln(ne_sod);
    end
    
    else{Ветка сработает только, если всё нормально}
    begin
      i := 0;
      j := 0;
      k := 1;{Количество строк}
      bool := true;
      s1a := '';{В ней буду хранить последовательность гена}
      while not (j = kon) do
      begin
        i := i + 1;
        if s1[i] in ['A', 'a', 'U', 'u', 'G', 'g', 'C', 'c']  then
        begin
          j := j + 1;
          if not bool then
          begin
            if t then
              s1a := s1[i - 1] + s1a;
            t := false;
            s1a := s1a + s1[i];
          end;
        end;
        if s1[i] = '4' then
        begin
          k := k + 1;
          kon1 := -1;
          if bool then
            nach1 := -1;
        end;
        if bool then
          nach1 := nach1 + 1;
        if (j = nach) and bool then
        begin
          bool := false;
          nach_str := k;
        end;
        kon1 := kon1 + 1;
        kon_str := k;
      end;
      
       {Вывод}
      Writeln('Start in sequence: ', nach);
      Writeln('End in sequence: ', kon);
      Writeln('Starting line number: ', nach_str);
      Writeln('Sequence number per line: ', nach1);
      Writeln('The line number of the end: ', kon_str);
      Writeln('Sequence number per line: ', kon1);
      Writeln('The sequence of the gene: ', s1a);
    end;
  end;
end.