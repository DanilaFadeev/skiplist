program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' { ������� �����},
  SkpLstClass in 'SkpLstClass.pas',
  Unit2 in 'Unit2.pas' { ���� �������� },
  Unit3 in 'Unit3.pas' { ���� ������� },
  ABOUT in 'ABOUT.pas' { � ������������ };

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
