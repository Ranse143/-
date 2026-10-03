object WebModule1: TWebModule1
  OldCreateOrder = False
  OnCreate = WebModule1Create
  Actions = <>
  Left = 0
  Top = 0
  Height = 230
  Width = 415
  object FDConnection1: TFDConnection
    Left = 40
    Top = 40
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 40
    Top = 96
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 40
    Top = 152
  end
end