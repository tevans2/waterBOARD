unit dmWaterBoard_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TdmWaterboard = class(TDataModule)
    qryWaterBoard: TADOQuery;
    dscWaterBoard: TDataSource;
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
var
  sFilePath: String;
begin
  // Create a new TADOConnection object with dmWaterboard as its owner.
  conWaterBoard_code := TADOConnection.Create(dmWaterboard);

  // Ensure the connection is initially closed.
  conWaterBoard_code.Close;

  // The file is expected to be located in the same directory as the executing program (ParamStr(0) gives the path of the executing program).
  sFilePath := ExtractFilePath(Copy(ParamStr(0), 0, pos('Win32', ParamStr(0))))
    + 'waterBOARD.mdb';

  // Configure the connection string to point to a Microsoft Access database file named 'waterBOARD.mdb'.
  // Also specify the provider as 'Microsoft.Jet.OLEDB.4.0' and disable persisting security info and login prompt for the connection.
  conWaterBoard_code.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;Data Source =' + sFilePath +
    ';Persist Security Info = False';
  conWaterBoard_code.LoginPrompt := False;

  // Open the database connection.
  conWaterBoard_code.Open;

  // Assign the database connection to the qryWaterBoard query object.
  qryWaterBoard.Connection := conWaterBoard_code;
end;


end.
