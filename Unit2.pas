unit Unit2;
{ Настройки }
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button1: TButton;
    GroupBox1: TGroupBox;
    StaticText2: TStaticText;
    Edit1: TEdit;

    procedure Button1Click(Sender: TObject); // выход
    procedure FormCreate(Sender: TObject); // создание формы
    procedure RadioButton1Click(Sender: TObject); // выбор светлой темы
    procedure RadioButton2Click(Sender: TObject); // выбор темной темы
    procedure Edit1KeyPress(Sender: TObject; var Key: Char); // верхняя граница случайного интервала
  private
    { Private declarations }
  public
    thmDark, thmLight : boolean; // темы
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses Unit1;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not( Key in ['0'..'9', #13, #8]) or ( (Length(Edit1.Text) > 4) and (Key <> #8)) then
    Key := #0
  else
    if Key = #13 then
      Button1.SetFocus;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin

  thmLight := true;
  thmDark := false;

  if thmLight = true then
    RadioButton1.Checked := true
  else begin
    RadioButton2.Checked := true;
    thmDark := true;
  end;
end;

procedure TForm2.RadioButton1Click(Sender: TObject);
begin
  thmLight := true;
  thmDark := false;
  if assigned(List) then
    Form1.PrintList(List.GetList);
end;

procedure TForm2.RadioButton2Click(Sender: TObject);
begin
  thmDark := true;
  thmLight := false;
  if assigned(List) then
    Form1.PrintList(List.GetList);
end;

end.
