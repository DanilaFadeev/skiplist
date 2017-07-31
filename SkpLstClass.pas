unit SkpLstClass;

interface

uses System.SysUtils;

const
  MaxLevel=20; // максимальный уровень списка
  inf=200000;

type
  Valuetype = longint; // тип инфочасти
  Snode=^Skiptype;
  Skiptype=record
             key:longint;
             value:Valuetype;
             next:array[1..MaxLevel] of Snode;
           end;
  Listtype=record
             level:integer;
             header,tail:Snode;
           end;
type
SkipList = class
  private
    List : Listtype; // объект списка
    emptyNode : Skiptype; // пустой узел
    update : array[1..MaxLevel] of Snode; // буферный узел

    function RandomLevel() : integer; // генераци€ случайного уровн€

  public
    property GetList : Listtype read List write List; // дл€ передачи списка вовне

    function Search(key : longint; var res : Valuetype) : boolean; // поиск
    procedure Insert(key : longint; value : Valuetype); // вставка
    procedure Remove(key : longint); // удаление

    constructor Create();
end;

implementation

constructor SkipList.Create();
var
  i:integer;
begin
  // «аполн€ет раздел пам€ти значением байта или символа-заполнител€
  fillchar(Emptynode,sizeof(Emptynode),0);
  List.level:=1;

  // —оздание нового списка
  new(List.header);
  List.header^:=Emptynode;
  List.header^.key:=-inf;

  new(List.tail);
  List.tail^:=Emptynode;
  List.tail^.key:=inf;

  for i:=1 to MaxLevel do
    List.header^.next[i]:=List.tail;

  for i:=1 to MaxLevel do
    update[i]:=List.header;
end;

function SkipList.RandomLevel : integer;
var
  lev : integer;
begin
  lev := 1;
  while random < 0.5 do lev := lev + 1; // веро€тность р = 0.5
  RandomLevel := lev;
end;

function SkipList.Search(key : longint; var res : Valuetype) : boolean;
var
  x:Snode;
  i:integer;
begin
  x:=List.header;

  // поиск элемента
  for i:=List.level downto 1 do
  begin
    while x^.next[i]^.key < key do
      x:=x^.next[i];
  end;

  // проверка на результат
  x:=x^.next[1];
  if x^.key=key then
  begin
    res := x^.value;
    Search := true
  end
  else
   Search := false;
end;

Procedure SkipList.Insert(key : longint; value : Valuetype);
var
  x:Snode;
  lvl, i : integer;
  update : array[1..MaxLevel] of Snode;
begin
  x:=List.header;

  // рассчет позиции
  for i := List.level downto 1 do
  begin
    while x^.next[i]^.key < key do
       x := x^.next[i];
    update[i] := x;
  end;

  if x^.next[1]^.key = key then
  begin
    x:=x^.next[1];
    x^.value:= value;
  end else
  begin
    // определение уровн€
    lvl := RandomLevel;
    if lvl > List.level then begin
      for i := List.level + 1 to lvl do
        update[i] := List.header;
      List.level := lvl;
    end;

    new(x);
    x^ := Emptynode;
    x^.key := key;
    x^.value := value;

    // вставка на требуемые уровни
    for i:=1 to lvl do begin
      x^.next[i] := update[i]^.next[i];
      update[i]^.next[i] := x;
    end;
  end;
end;

Procedure SkipList.Remove(key : longint);
var
  x:Snode;
  i:integer;
  update:array[1..MaxLevel] of Snode;
begin
  x:=List.header;

  for i:=List.level downto 1 do begin
    while x^.next[i]^.key<key do x:=x^.next[i];
    update[i]:=x;
  end;

  if x^.next[1]^.key = key then begin
    x:=x^.next[1];
    for i:=1 to List.level do begin
      if update[i]^.next[i]^.key <> key then break;
      update[i]^.next[i]:=x^.next[i];
    end;
    dispose(x);

    while (List.level > 1) and (List.header^.next[List.level] = List.tail) do
      dec(List.level);
  end;
end;

end.
