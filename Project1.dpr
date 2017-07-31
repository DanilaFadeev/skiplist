program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' { Главная форма},
  SkpLstClass in 'SkpLstClass.pas',
  Unit2 in 'Unit2.pas' { Окно настроек },
  Unit3 in 'Unit3.pas' { Окно справки },
  ABOUT in 'ABOUT.pas' { О разработчике };

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
