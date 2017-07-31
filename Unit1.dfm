object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1057#1087#1080#1089#1086#1082' '#1089' '#1087#1088#1086#1087#1091#1089#1082#1072#1084#1080' (Skip List)'
  ClientHeight = 505
  ClientWidth = 899
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 476
    Width = 65
    Height = 19
    Caption = #1057#1082#1086#1088#1086#1089#1090#1100':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object LabelStatus: TLabel
    Left = 768
    Top = 478
    Width = 4
    Height = 17
    Alignment = taRightJustify
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 271
    Top = 477
    Width = 20
    Height = 19
    Caption = '0,5'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 778
    Top = 471
    Width = 113
    Height = 30
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 0
    OnClick = Button1Click
  end
  object ScrollBar1: TScrollBar
    Left = 87
    Top = 479
    Width = 178
    Height = 17
    Min = 10
    PageSize = 0
    Position = 50
    TabOrder = 1
    OnScroll = ScrollBar1Scroll
  end
  object ScrollBox1: TScrollBox
    Left = 8
    Top = 8
    Width = 883
    Height = 457
    TabOrder = 2
    object Image1: TImage
      Left = -2
      Top = -2
      Width = 880
      Height = 455
    end
  end
  object MainMenu1: TMainMenu
    Left = 864
    Top = 8
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N5: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072'..'
        OnClick = N5Click
      end
      object N6: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        OnClick = N6Click
      end
    end
    object N18: TMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100
      object N17: TMenuItem
        Caption = #1055#1091#1089#1090#1086#1081' '#1089#1087#1080#1089#1086#1082
        OnClick = N17Click
      end
      object N16: TMenuItem
        Caption = #1057#1083#1091#1095#1072#1081#1085#1099#1081' '#1089#1087#1080#1089#1086#1082
        OnClick = N16Click
      end
    end
    object N2: TMenuItem
      Caption = #1050#1086#1084#1072#1085#1076#1099
      object N7: TMenuItem
        Caption = #1055#1086#1080#1089#1082
        OnClick = N7Click
      end
      object N8: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        OnClick = N8Click
      end
      object N9: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        OnClick = N9Click
      end
    end
    object N3: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
      object N13: TMenuItem
        Caption = #1054#1073' '#1072#1083#1075#1086#1088#1080#1090#1084#1077
        OnClick = N13Click
      end
      object N15: TMenuItem
        Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082
        OnClick = N15Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = #1090#1077#1082#1089#1090#1086#1074#1099#1077' (*.txt, *.doc)|*.txt; *.doc'
    Left = 832
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    Filter = #1090#1077#1082#1089#1090#1086#1074#1099#1077' (*.txt, *.doc)|*.txt; *.doc'
    Left = 800
    Top = 8
  end
end
