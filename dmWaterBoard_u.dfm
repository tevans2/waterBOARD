object dmWaterboard: TdmWaterboard
  OnCreate = DataModuleCreate
  Height = 854
  Width = 1285
  PixelsPerInch = 120
  object qryWaterBoard: TADOQuery
    Connection = conWATERboard
    Parameters = <>
    Left = 400
    Top = 260
  end
  object dscWaterBoard: TDataSource
    DataSet = qryWaterBoard
    Left = 400
    Top = 370
  end
  object conWATERboard: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=C:\Us' +
      'ers\Tate\Desktop\waterBOARD\Delphi\GUI design\waterBOARD\waterBO' +
      'ARD.mdb;Mode=Share Deny None;Persist Security Info=False;Jet OLE' +
      'DB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Datab' +
      'ase Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locki' +
      'ng Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global B' +
      'ulk Transactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:' +
      'Create System Database=False;Jet OLEDB:Encrypt Database=False;Je' +
      't OLEDB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact Wit' +
      'hout Replica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 160
    Top = 320
  end
end
