object Form2: TForm2
  Left = 0
  Top = 0
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 179
  ClientWidth = 272
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 8
    Width = 249
    Height = 60
    Caption = #1058#1077#1084#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object RadioButton1: TRadioButton
    Left = 43
    Top = 35
    Width = 94
    Height = 17
    Caption = #1057#1074#1077#1090#1083#1072#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 143
    Top = 35
    Width = 90
    Height = 17
    Caption = #1058#1077#1084#1085#1072#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = RadioButton2Click
  end
  object Button1: TButton
    Left = 189
    Top = 145
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 3
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 82
    Width = 249
    Height = 57
    Caption = #1057#1083#1091#1095#1072#1081#1085#1099#1081' '#1089#1087#1080#1089#1086#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object StaticText2: TStaticText
      Left = 16
      Top = 24
      Width = 153
      Height = 22
      Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1095#1080#1089#1083#1086':'
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 175
      Top = 20
      Width = 65
      Height = 26
      TabOrder = 1
      Text = '100'
      OnKeyPress = Edit1KeyPress
    end
  end
end
