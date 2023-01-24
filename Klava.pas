Unit Klava;
interface
Uses  GraphABC;
var (m,wx,wy,g) := (100, 300,300,10);
procedure Draw(x, y, dx, dy: integer);
implementation
procedure Draw(x, y, dx, dy: integer);
var
  turn: array [1..1000] of Boolean;
  a, b, d, t: integer;
  f: Boolean;
  i: integer;
begin
  SetWindowSize(790, 500);
  SetWindowCaption('Фракталы. Кривая Дракона');
  f := true;
  for a := 1 to 64 do
  begin
    turn[2 * a - 1] := f;
    f := not f;
    turn[2 * a] := turn[a];
  end;
  b := 0;
  d := 1;
  f := false;
  MoveTo(x, y);
  for a := 1 to 128 do
  begin
    for i := 1 to 127 * 4 do
    begin
      b := b + d; x := x + dx; y := y + dy;
      LineTo(x, y);
      if f and not turn[b] or not f and turn[b] then
      begin
        t := dy;
        dy := -dx;
      end
      else
      begin
        t := -dy;
        dy := dx;
      end;
      dx := t;
    end;
    b := b + d; d := -d;
    f := not f;
    x := x + dx; y := y + dy;
    LineTo(x, y);
    if turn[a] then
    begin
      t := dy;
      dy := -dx;
    end
    else
    begin
      t := -dy;
      dy := dx;
    end;
    dx := t;
  end;
end;
 
Procedure ris(x1,y1,x2,y2,k:integer);
begin
     If k>0 then begin
          var xn:=(x1+x2) div 2 +(y2-y1) div 2;
          var yn:=(y1+y2) div 2 -(x2-x1) div 2;
          ris(x1,y1,xn,yn,k-1);
          ris(x2,y2,xn,yn,k-1)
     end
     else line(x1,y1,x2,y2)
end;
 
Procedure KeyDown(k: integer);
begin
 case K of
    VK_Down: wy -= 10;
    VK_Up: wy += 10; 
    VK_Left: wx += 10;  
    VK_Right: wx -= 10;
    VK_Escape: halt(1);
    VK_A: if m < 500 then m+=10;
    VK_Z: if m > 20 then m-=10;
    VK_S: if g < 15 then g+=1;
    VK_X: if g > 2 then g -=1;
   end;
 Window.Clear; 
 ris(wx-m,wy,wx+m,wy,g);
 Redraw;
end; 
 
Begin
     SetWindowCaption('Фракталы: Кривая Дракона');
     SetWindowSize(700,512);
     textout(10, 100, 'Left - влево');
     textout(10, 120, 'Right - вправо');
     textout(10, 140, 'Up - вверх');
     textout(10, 160, 'Down - вниз');
     textout(10, 180, 'z - отдалить');
     textout(10, 200, 'x - уменьшение глубины');
     textout(10, 220, 'a - приблизить');
     textout(10, 260, 'S - Седующая глубина');
     LockDrawing;
     KeyDown(0);
     OnkeyDown += KeyDown;
End.