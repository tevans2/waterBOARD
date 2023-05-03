unit clsUSER_u;

interface

uses SysUtils, dmWaterBoard_u, clsADDRESS_u;

type
  TUser = class(TObject)
  private
    first_name: String;
    surname: String;
    username: String;
    password: String;
    email: String;
    address_id: Integer;

  public
    constructor Create(first_name, surname, username, password, email,
      street_name, suburb, unit_number: string); overload;
    constructor Create(username, password: string); overload;
    procedure InsertUserRecord;
    function CheckLogin: Boolean;
  end;

implementation

{ TUser }

constructor TUser.Create(first_name, surname, username, password, email,
  street_name, suburb, unit_number: string);
var
  objAddress: TAddress;
begin
  objAddress := TAddress.Create(unit_number, street_name, suburb);
  objAddress.InsertAddressRecord;

  Self.address_id := objAddress.GetAddressID;

  Self.first_name := first_name;
  Self.surname := surname;
  Self.email := email;
  Self.username := username;
  Self.password := password;
end;

constructor TUser.Create(username, password: string);
begin

end;

procedure TUser.InsertUserRecord;
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('INSERT INTO USER');
    qryWaterBoard.SQL.Add
      ('(first_name, surname, email, username, password, address_id)');
    qryWaterBoard.SQL.Add
      ('VALUES (:first_name, :surname, :email, :username, :password, :address_id)');
    with qryWaterBoard.Parameters do
    begin
      ParamByName('first_name').Value := Self.first_name;
      ParamByName('surname').Value := Self.surname;
      ParamByName('email').Value := Self.email;
      ParamByName('username').Value := Self.username;
      ParamByName('password').Value := Self.password;
      ParamByName('address_id').Value := Self.address_id;
    end;

    qryWaterBoard.ExecSQL;
  end;
end;

function TUser.CheckLogin: Boolean;
begin

end;

end.
