unit Unit1;
{
  Курсовой проект
  на тему "Разработка класса список с пропусками"
  подготовил: Демидович Д.Д., гр. 52492
  МРК, 2017
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, SkpLstClass,
  Vcl.Menus, Vcl.Imaging.jpeg;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    LabelStatus: TLabel;
    ScrollBar1: TScrollBar;
    Label3: TLabel;
    ScrollBox1: TScrollBox;
    procedure drawNode(i,j : integer; key : longint); // Рисование узла
    procedure drawArrow(i1, j1, i2, j2 : integer); // Рисование связи узлов
    procedure PrintList(List : Listtype); // Отрисовка списка
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer); // изменение скорости выполнения операций
    function  VisualSearch(key : longint; var res : Valuetype) : boolean; // Визуальный поиск
    procedure Button1Click(Sender: TObject); // выход из программы
    procedure N16Click(Sender: TObject); // создание случайного списка
    procedure N8Click(Sender: TObject); // добавление элемента в список
    procedure N17Click(Sender: TObject); // создание пустого списка
    procedure N9Click(Sender: TObject); // удаление элемента
    procedure N7Click(Sender: TObject); // поиск элемента
    procedure N5Click(Sender: TObject); // открытие из файла
    procedure N6Click(Sender: TObject); // сохранение в файл
    procedure N3Click(Sender: TObject);  // открытие окна настроек
    procedure N13Click(Sender: TObject); // открытие справки
    procedure N15Click(Sender: TObject); // информация о разработчике

  private
    { Private declarations }
  public

  end;

var
  Form1: TForm1;
  List : SkipList; // объект списка
  fin, fout : textfile;

implementation

{$R *.dfm}

uses Unit2, Unit3, About;

procedure TForm1.PrintList(List : Listtype);
var
  item, temp : Snode;
  i, j, xpos, bufpos, max : integer;
begin
  { Определение размера холста}
  item := List.header;
  max := 1;
  i := 2;
  while item^.next[1] <> List.tail do
  begin
    inc(i);
    item := item^.next[1];
  end;

  { Ширина холста }
  i := (i * 60) + 35;
  if i < 880 then i := 880;

  if Image1.Width <> i then begin
      Image1.Width := i;
  end;

  { Высота холста }
  j := (List.level * 55) + 10;
  if j < 455 then j := 455;

  if Image1.Height <> j then begin
      Image1.Height := j;
  end;

  Image1.Picture.Bitmap.SetSize(Image1.Width, Image1.Height);

  if Form2.thmDark = true then begin
    Image1.Canvas.Brush.Color := clBlack;
    Image1.Canvas.Pen.Color := clWhite;
    Image1.Canvas.Font.Color := clWhite;
  end else begin
    Image1.Canvas.Brush.Color := clWhite;
    Image1.Canvas.Pen.Color := clBlack;
    Image1.Canvas.Font.Color := clBlack;
  end;
  Image1.Canvas.Pen.Width := 1;

  Image1.Canvas.Rectangle(0,0, Image1.Width, Image1.Height);
  { Вывод каждого уровня }
  for i := 1 to List.level do begin

    item := List.header;
    xpos := 1;

    temp := List.header;
    bufpos := 0;

    { Вывод Header }
    drawNode(0, i-1, item^.key);

    { Рисование узлов }
    while item^.next[i] <> List.tail do begin

      if i > 1 then
        while (temp^.next[1]^.key <> item^.next[i]^.key) do begin
          inc(xpos);
          temp := temp^.next[1];
        end;

      drawNode(xpos, i-1, item^.next[i]^.key);
      if i = 1 then
        drawArrow(xpos-1, i-1, xpos, i-1)
      else
        drawArrow(bufpos, i-1, xpos, i-1);

      if i > 1 then
        drawArrow(xpos, i-2, xpos, i-1);

      if i = 1 then begin
        inc(xpos);
        max := xpos;
      end;

      item := item^.next[i];
      bufpos := xpos;

    end;

    { Вывод Tail }
    drawNode(max, i-1, List.tail^.key);
    drawArrow(xpos, i-1, max, i-1);
    drawArrow(max-1, i-1, max, i-1);

    { Подпись уровней }
    Image1.Canvas.TextOut(15, 15+(i-1)*50, inttostr(i-1));

  end;
end;

procedure TForm1.ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  Label3.Caption := FloatToStr(ScrollPos / 100);
end;

function TForm1.VisualSearch;
var
  x, temp : Snode;
  i, xpos, bufpos, steps1, steps2 : integer;
begin
  bufpos := 0;
  steps1 := 0; steps2 := 0;
  PrintList(List.GetList);
  Image1.Canvas.Pen.Color := clRed;
  Image1.Canvas.Pen.Width := 2;

  temp := List.GetList.header;
  while (temp^.key <> key) and (temp^.next[1] <> List.GetList.tail) do
  begin
    inc(steps1);
    temp := temp^.next[1];
  end;

  x := List.GetList.header;

  for i := List.GetList.level downto 1 do
  begin

    while x^.next[i]^.key <= key do begin

      temp := List.GetList.header;
      if i > 1 then begin
        xpos := 1;
        while (temp^.next[1]^.key <> x^.next[i]^.key) do begin
          inc(xpos);
          temp := temp^.next[1];
        end;
      end;

      if i > 1 then begin
        drawNode(xpos, i-1, x^.next[i]^.key);
        drawArrow(bufpos, i-1, xpos, i-1);
      end else begin
        drawNode(xpos+1, i-1, x^.next[i]^.key);
        drawArrow(xpos, i-1, xpos+1, i-1);
      end;

      if i = 1 then
        inc(xpos);

      inc(steps2);
      x := x^.next[i];
      bufpos := xpos;

      Application.ProcessMessages;
      Sleep(1000-round(StrToFloat(Label3.Caption)*1000));
    end;

    if i > 1 then
      drawArrow(xpos, i-2, xpos, i-1);
  end;


  if x^.key=key then
  begin
    res := x^.value;
    VisualSearch := true;
    LabelStatus.Caption := 'Элемент ' + inttostr(key) + ' найден: ' + inttostr(res)
      + '. Эффективность: x' + FloatToStrF(steps1/steps2, ffGeneral, 8, 4);

    { Отрисовка найденного элемента }
    Image1.Canvas.Pen.Color := clGreen;
    drawNode(xpos, 0, x^.key);
    drawArrow(xpos-1, 0, xpos, 0);
  end
  else begin
   VisualSearch := false;
   LabelStatus.Caption := 'Элемент не найден.';
  end;
end;

procedure TForm1.drawNode(i, j : integer; key : longint);
var
  ml, mb: integer;
begin
  ml := 35; // отступ слева
  mb := 10; // отступ сверху
  Image1.Canvas.Rectangle(ml+(60*i), mb+j*50, ml+50+(60*i), mb+30+(j*50));
  Image1.Canvas.TextOut(ml+5+(60*i), mb+7+j*50, inttostr(key));
end;

procedure TForm1.drawArrow(i1, j1, i2, j2 : integer);
var
  ml, mb : integer;
begin
  ml := 35; // отступ слева
  mb := 10; // отступ сверху

  if i1 < i2 then begin
    Image1.Canvas.MoveTo(ml + 50 +(60*i1), mb + 15 +(j1*50));
    Image1.Canvas.LineTo(ml + (60*i2), mb + 15 +j2*50);
  end;

  if j1 < j2 then begin
    Image1.Canvas.MoveTo(ml + 25 +(60*i1), mb + 30 +j1*50);
    Image1.Canvas.LineTo(ml + 25 +(60*i2), mb + (j2*50));
  end;

end;

{ Генерация случайного списка }
procedure TForm1.N13Click(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm1.N15Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TForm1.N16Click(Sender: TObject);
var
  i, maxval, count : integer;
begin
  Randomize;
  List :=  SkipList.Create;

  try
    count := StrToInt(InputBox('Случайный список', 'Число элементов:', '1'));
    maxval := StrToInt(Form2.Edit1.Text);

    for i := 1 to count do
      List.Insert(Random(maxval), Random(10000));

    PrintList(List.GetList);
    LabelStatus.Caption := 'Случайный список создан(' + IntToStr(count) + ')';
  except
    begin
      ShowMessage('Неккоректное число!');
      LabelStatus.Caption := 'Случайный список не создан!';
    end;
  end;

end;

procedure TForm1.N17Click(Sender: TObject);
begin
  List := SkipList.Create;
  PrintList(List.GetList);
  LabelStatus.Caption := 'Пустой список создан';
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.N5Click(Sender: TObject);
var
  key, value : integer;
begin
   if openDialog1.Execute then begin
    assignfile(fin, OpenDialog1.Filename);
    reset(fin);

    List := SkipList.Create;

    try
      while not eof(fin) do begin
        readln(fin, key, value);
        List.Insert(key, value);
      end;
    except on Error : Exception do
      ShowMessage('Ошибка чтения файла: ' + Error.Message);
    end;

    CloseFile(fin);
    PrintList(List.GetList);
    LabelStatus.Caption := 'Открыт: ' + OpenDialog1.Filename;
   end;
end;

procedure TForm1.N6Click(Sender: TObject);
var
  item : SNode;
begin

  if SaveDialog1.Execute then begin
    assignfile(fout, SaveDialog1.Filename);
    rewrite(fout);

    item := List.GetList.header.next[1];
    while item^.next[1] <> nil do begin
      writeln(fout, item^.key, ' ' + inttostr(item^.value));
      item := item^.next[1];
    end;

    CloseFile(fout);
    LabelStatus.Caption := 'Сохранено: ' + SaveDialog1.FileName;
  end;
end;

procedure TForm1.N7Click(Sender: TObject);
var
  key : string;
  res : integer;
begin
  if not Assigned(List) then begin
    ShowMessage('Создайте список!');
    exit;
  end;

  key := InputBox('Поиск элемента', 'Индекс', '0');
  if VisualSearch(StrToInt(key), res) then
    ShowMessage('Элемент ' + key + ' найден: ' + inttostr(res))
  else
    ShowMessage('Элемент не найден!');
end;

{ Добавление элемента в список}
procedure TForm1.N8Click(Sender: TObject);
var
  key, value : integer;
begin
  if not Assigned(List) then begin
    ShowMessage('Создайте список!');
    exit;
  end;

  key := StrToInt(InputBox('Добавление элемента', 'Индекс:', '0'));
  value := StrToInt(InputBox('Добавление элемента', 'Значение:', '0'));

  VisualSearch(key, value);
  Sleep(800);

  List.Insert(key, value);
  PrintList(List.GetList);

  LabelStatus.Caption := 'Элемент ' + inttostr(key) + '(' + inttostr(value) + ') добавлен';
end;

procedure TForm1.N9Click(Sender: TObject);
var
  key : string;
  res : integer;
begin
  if not Assigned(List) then begin
    ShowMessage('Создайте список!');
    exit;
  end;

  key := InputBox('Удаление элемента', 'Индекс', '0');

  VisualSearch(StrToInt(key), res);
  Sleep(800);

  List.Remove(StrToInt(key));
  PrintList(List.GetList);
  LabelStatus.Caption := 'Элемент ' + key + ' удален';
end;

{ Кнопка выход }
procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

end.

