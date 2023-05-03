unit clsADDRESS_u;

interface

uses SysUtils, dmWaterboard_u;

type
  TAddress = class(TObject)
  private
    unit_no: string;
    street_name: string;
    suburb: string;
    address_id: integer;

    function GenerateID: integer;

  public
    constructor Create(unit_no, street_name, suburb: string);
    function GetAddressID: integer;
    procedure InsertAddressRecord;
  end;

implementation

{ TAddress }

constructor TAddress.Create(unit_no, street_name, suburb: string);
begin
  Self.unit_no := unit_no;
  Self.street_name := street_name;
  Self.suburb := suburb;
  Self.address_id := GenerateID;
end;

function TAddress.GenerateID: integer;
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('SELECT MAX(address_id) AS MaxID FROM ADDRESS');
    qryWaterBoard.Open;

    if qryWaterBoard['MaxID'] > 0 then
      Result := qryWaterBoard['MaxID'] + 1
    else
      Result := 1;
  end;
end;

function TAddress.GetAddressID: integer;
begin
  Result := Self.address_id;
end;

procedure TAddress.InsertAddressRecord;
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('INSERT INTO ADDRESS');
    qryWaterBoard.SQL.Add('(address_id, unit_no, street, suburb)');
    qryWaterBoard.SQL.Add('VALUES (:address_id, :unit_no, :street, :suburb)');
    with qryWaterBoard.Parameters do
    begin
      ParamByName('address_id').Value := Self.address_id;
      ParamByName('unit_no').Value := Self.unit_no;
      ParamByName('street').Value := Self.street_name;
      ParamByName('suburb').Value := Self.suburb;
    end;

    qryWaterBoard.ExecSQL;
  end;
end;

end.
