unit dmWaterBoard_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TdmWaterboard = class(TDataModule)
    qryWaterBoard: TADOQuery;
    dscWaterBoard: TDataSource;
    conWATERboard: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmWaterboard: TdmWaterboard;
  conWaterBoard_code: TADOConnection;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdmWaterboard.DataModuleCreate(Sender: TObject);
begin
//  conWaterBoard_code := TADOConnection.Create(dmWaterboard);
//
//  conWaterBoard_code.Close;
//  conWaterBoard_code.ConnectionString :=
//    'Provider=Microsoft.Jet.OLEDB.4.0;Data Source =' +
//    ExtractFilePath(ParamStr(0)) + 'waterBOARD.mdb' +
//    ';Persist Security Info = False';
//  conWaterBoard_code.LoginPrompt := False;
//  conWaterBoard_code.Open;
//
//  qryWaterBoard.Connection := conWaterBoard_code;
end;

end.
