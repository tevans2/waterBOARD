object dmWaterboard: TdmWaterboard
  OnCreate = DataModuleCreate
  Height = 683
  Width = 1028
  object qryWaterBoard: TADOQuery
    Connection = conWATERboard
    Parameters = <>
    Left = 320
    Top = 208
  end
  object dscWaterBoard: TDataSource
    DataSet = qryWaterBoard
    Left = 320
    Top = 296
  end
  object conWATERboard: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=K:\IT' +
      ' 2023\Grade 12\Submissions\1. PAT\Evans Tate\PAT 2023\waterBoard' +
      ' (Current)\waterBOARD\waterBOARD.mdb;Mode=Share Deny None;Persis' +
      't Security Info=False;Jet OLEDB:System database="";Jet OLEDB:Reg' +
      'istry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Ty' +
      'pe=5;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial ' +
      'Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Da' +
      'tabase Password="";Jet OLEDB:Create System Database=False;Jet OL' +
      'EDB:Encrypt Database=False;Jet OLEDB:Don'#39't Copy Locale on Compac' +
      't=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB' +
      ':SFP=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 128
    Top = 256
  end
end
