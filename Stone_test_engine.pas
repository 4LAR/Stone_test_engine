uses crt;
function code(kod: integer;slovo: string) : string; 
var
  i, j, g: integer;
  slovofinal: string;
begin
  for g := 1 to kod do 
    begin
      slovofinal := '';
      for i := 1 to length(slovo) do 
        begin
          j := 0;
          while true do 
            begin
              j := j + 1;
              if copy(slovo, i, 1) = chr(j) then
                begin
                  slovofinal := slovofinal + j + '/';
                  break ;
                end ;
            end;
        end;
      slovo := slovofinal;
    end;
  code := slovofinal;
end; 
function decode(kod: integer;slovo: string) : string; 
var
  i, g, j: integer;
  slovofinal, buf: string;
begin
  for g := 1 to kod do 
    begin
      slovofinal := '';
      for i := 1 to length(slovo) do 
        begin
          if copy(slovo, i, 1) <> '/' then
            buf := buf + copy(slovo, i, 1)  
          else 
            while true do 
              begin
                j := j + 1;
                if buf = j + '' then
                  begin
                    slovofinal := slovofinal + chr(j);
                    buf := '';
                    j := 0;
                    break ;
                  end ;
              end;
        end;
      slovo := slovofinal;
      decode := slovofinal;
    end;
end; 
var
  name_file, name_test, key, buf, otv: string;
  i, j, p, o, t, pr: integer;
  sc: integer;
  tfile: textFile;
begin
  while true do 
    begin
      clrscr;
      writeln('Stone Test Engine beta 2');
      writeln;
      writeln('<new> - Создать новый тест');
      //writeln('<edit> - Изменить существующий тест'); beta 3
      writeln('<open> - Открыть и запустить тест');
      writeln;
      write('>');
      readln(key);
      if key = 'new' then
        begin
          clrscr;
          write('Название файла : ');
          readln(name_file);writeln;
          assign(tfile, name_file);
          rewrite(tfile);
          clrscr;
          write('Название теста : ');
          readln(name_test);
          writeln(tfile, name_test);
          writeln;
          write('Количество заданий : ');
          readln(t);
          writeln(tfile, t);
          for i := 1 to t do begin
            clrscr;
            writeln('Вопрос #', i,' из ',t);
            write('Вопрос : ');
            readln(buf);
            writeln(tfile, buf);
            write('Вариантов ответов : ');
            readln(p);
            writeln(tfile, p);
            for j := 1 to p do begin
              write(j,')');
              readln(buf);
              writeln(tfile, buf);
            end;
            write('Правильный ответ : ');
            readln(buf);
            writeln(tfile, buf);
          end;
          clrscr;
          close(tfile);
          writeln;
          writeln('Ваш тест был сохрвнён');
          writeln;writeln('Press enter');
          readln;
        end 
      else if key = 'edit' then
        begin
        end 
      else if key = 'open' then
        begin
          write('file name : ');
          readln(name_file);
          assign(tfile, name_file);
          reset(tfile);
          readln(tfile, name_test);
          clrscr;
          writeln;
          writeln(' ', name_test);writeln;
          writeln('Начать тест?');
          writeln('1)Да');writeln('2)Нет');
          write('Ответ : ');readln(buf);
          if buf = '1' then begin
            readln(tfile, t);
            for i := 1 to t do 
              begin
                clrscr;
                writeln('  вопрос #', i);
                readln(tfile, buf);
                readln(tfile, p);
                writeln(buf);
                for j := 1 to p do 
                  begin
                    readln(tfile, buf);
                    writeln(j, ')', buf);
                  end;
                write('Ответ :');
                readln(otv);
                readln(tfile, buf);
                if otv = buf then
                  pr := pr + 1 ;
              end;
            close(tfile);
            clrscr;
            writeln('вы ответили правильно на ', pr, ' из ', t);
            pr := 0;
            writeln;
            writeln('Press enter... ');
            readln;
          end 
        end
      else if key = 'exit' then
        break  ;
    end;
end.