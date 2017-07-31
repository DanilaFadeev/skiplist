unit Unit1;
{
  �������� ������
  �� ���� "���������� ������ ������ � ����������"
  ����������: ��������� �.�., ��. 52492
  ���, 2017
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
    procedure drawNode(i,j : integer; key : longint); // ��������� ����
    procedure drawArrow(i1, j1, i2, j2 : integer); // ��������� ����� �����
    procedure PrintList(List : Listtype); // ��������� ������
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer); // ��������� �������� ���������� ��������
    function  VisualSearch(key : longint; var res : Valuetype) : boolean; // ���������� �����
    procedure Button1Click(Sender: TObject); // ����� �� ���������
    procedure N16Click(Sender: TObject); // �������� ���������� ������
    procedure N8Click(Sender: TObject); // ���������� �������� � ������
    procedure N17Click(Sender: TObject); // �������� ������� ������
    procedure N9Click(Sender: TObject); // �������� ��������
    procedure N7Click(Sender: TObject); // ����� ��������
    procedure N5Click(Sender: TObject); // �������� �� �����
    procedure N6Click(Sender: TObject); // ���������� � ����
    procedure N3Click(Sender: TObject);  // �������� ���� ��������
    procedure N13Click(Sender: TObject); // �������� �������
    procedure N15Click(Sender: TObject); // ���������� � ������������

  private
    { Private declarations }
  public

  end;

var
  Form1: TForm1;
  List : SkipList; // ������ ������
  fin, fout : textfile;

implementation

{$R *.dfm}

uses Unit2, Unit3, About;

procedure TForm1.PrintList(List : Listtype);
var
  item, temp : Snode;
  i, j, xpos, bufpos, max : integer;
begin
  { ����������� ������� ������}
  item := List.header;
  max := 1;
  i := 2;
  while item^.next[1] <> List.tail do
  begin
    inc(i);
    item := item^.next[1];
  end;

  { ������ ������ }
  i := (i * 60) + 35;
  if i < 880 then i := 880;

  if Image1.Width <> i then begin
      Image1.Width := i;
  end;

  { ������ ������ }
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
  { ����� ������� ������ }
  for i := 1 to List.level do begin

    item := List.header;
    xpos := 1;

    temp := List.header;
    bufpos := 0;

    { ����� Header }
    drawNode(0, i-1, item^.key);

    { ��������� ����� }
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

    { ����� Tail }
    drawNode(max, i-1, List.tail^.key);
    drawArrow(xpos, i-1, max, i-1);
    drawArrow(max-1, i-1, max, i-1);

    { ������� ������� }
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
    LabelStatus.Caption := '������� ' + inttostr(key) + ' ������: ' + inttostr(res)
      + '. �������������: x' + FloatToStrF(steps1/steps2, ffGeneral, 8, 4);

    { ��������� ���������� �������� }
    Image1.Canvas.Pen.Color := clGreen;
    drawNode(xpos, 0, x^.key);
    drawArrow(xpos-1, 0, xpos, 0);
  end
  else begin
   VisualSearch := false;
   LabelStatus.Caption := '������� �� ������.';
  end;
end;

procedure TForm1.drawNode(i, j : integer; key : longint);
var
  ml, mb: integer;
begin
  ml := 35; // ������ �����
  mb := 10; // ������ ������
  Image1.Canvas.Rectangle(ml+(60*i), mb+j*50, ml+50+(60*i), mb+30+(j*50));
  Image1.Canvas.TextOut(ml+5+(60*i), mb+7+j*50, inttostr(key));
end;

procedure TForm1.drawArrow(i1, j1, i2, j2 : integer);
var
  ml, mb : integer;
begin
  ml := 35; // ������ �����
  mb := 10; // ������ ������

  if i1 < i2 then begin
    Image1.Canvas.MoveTo(ml + 50 +(60*i1), mb + 15 +(j1*50));
    Image1.Canvas.LineTo(ml + (60*i2), mb + 15 +j2*50);
  end;

  if j1 < j2 then begin
    Image1.Canvas.MoveTo(ml + 25 +(60*i1), mb + 30 +j1*50);
    Image1.Canvas.LineTo(ml + 25 +(60*i2), mb + (j2*50));
  end;

end;

{ ��������� ���������� ������ }
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
    count := StrToInt(InputBox('��������� ������', '����� ���������:', '1'));
    maxval := StrToInt(Form2.Edit1.Text);

    for i := 1 to count do
      List.Insert(Random(maxval), Random(10000));

    PrintList(List.GetList);
    LabelStatus.Caption := '��������� ������ ������(' + IntToStr(count) + ')';
  except
    begin
      ShowMessage('������������ �����!');
      LabelStatus.Caption := '��������� ������ �� ������!';
    end;
  end;

end;

procedure TForm1.N17Click(Sender: TObject);
begin
  List := SkipList.Create;
  PrintList(List.GetList);
  LabelStatus.Caption := '������ ������ ������';
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
      ShowMessage('������ ������ �����: ' + Error.Message);
    end;

    CloseFile(fin);
    PrintList(List.GetList);
    LabelStatus.Caption := '������: ' + OpenDialog1.Filename;
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
    LabelStatus.Caption := '���������: ' + SaveDialog1.FileName;
  end;
end;

procedure TForm1.N7Click(Sender: TObject);
var
  key : string;
  res : integer;
begin
  if not Assigned(List) then begin
    ShowMessage('�������� ������!');
    exit;
  end;

  key := InputBox('����� ��������', '������', '0');
  if VisualSearch(StrToInt(key), res) then
    ShowMessage('������� ' + key + ' ������: ' + inttostr(res))
  else
    ShowMessage('������� �� ������!');
end;

{ ���������� �������� � ������}
procedure TForm1.N8Click(Sender: TObject);
var
  key, value : integer;
begin
  if not Assigned(List) then begin
    ShowMessage('�������� ������!');
    exit;
  end;

  key := StrToInt(InputBox('���������� ��������', '������:', '0'));
  value := StrToInt(InputBox('���������� ��������', '��������:', '0'));

  VisualSearch(key, value);
  Sleep(800);

  List.Insert(key, value);
  PrintList(List.GetList);

  LabelStatus.Caption := '������� ' + inttostr(key) + '(' + inttostr(value) + ') ��������';
end;

procedure TForm1.N9Click(Sender: TObject);
var
  key : string;
  res : integer;
begin
  if not Assigned(List) then begin
    ShowMessage('�������� ������!');
    exit;
  end;

  key := InputBox('�������� ��������', '������', '0');

  VisualSearch(StrToInt(key), res);
  Sleep(800);

  List.Remove(StrToInt(key));
  PrintList(List.GetList);
  LabelStatus.Caption := '������� ' + key + ' ������';
end;

{ ������ ����� }
procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

end.

