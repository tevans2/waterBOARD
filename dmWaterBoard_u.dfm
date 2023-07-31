object dmWaterboard: TdmWaterboard
  OnCreate = DataModuleCreate
  Height = 854
  Width = 1285
  PixelsPerInch = 120
  object qryWaterBoard: TADOQuery
    Parameters = <>
    Left = 400
    Top = 260
  end
  object dscWaterBoard: TDataSource
    DataSet = qryWaterBoard
    Left = 400
    Top = 370
  end
end
