unit clsUSER_u;

interface

uses SysUtils, Vcl.Dialogs, dmWaterBoard_u, clsADDRESS_u, clsValidation_u,
  BCrypt;

type
  TUser = class(TObject)
  private
    user_id: integer;
    first_name: String;
    surname: String;
    username: String;
    password: String;
    email: String;
    address_id: integer;

  public
    constructor Create(first_name, surname, username, password,
      email: string); overload;
    constructor Create(username, password: string); overload;
    procedure InsertUserRecord(objAddress: TAddress);
    procedure DeleteUserRecord(UserID: integer);
    procedure UpdateUserRecord(UserID: integer; username: string);

    function GetUserID: integer;
    function GetAddressID: integer;
    function GetName: String;

    function CheckLogin: Boolean;
    function Validate(var Validation_Str: String): TArray<integer>;
    procedure AddToArray(var Input_Array: TArray<integer>; To_add: integer);
  end;

implementation

{ TUser }

uses frmSignUp_u;

constructor TUser.Create(first_name, surname, username, password,
  email: string);
begin
  Self.first_name := first_name;
  Self.surname := surname;
  Self.email := email;
  Self.username := username;
  Self.password := password;
end;

constructor TUser.Create(username, password: string);
begin
  Self.username := username;
  Self.password := password;
end;

procedure TUser.DeleteUserRecord(UserID: integer);
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('DELETE FROM [USER]');
    qryWaterBoard.SQL.Add('WHERE user_ID = :UserID');
    with qryWaterBoard.Parameters do
    begin
      ParamByName('UserID').Value := UserID;
    end;

    qryWaterBoard.ExecSQL;
  end;
end;

function TUser.GetAddressID: integer;
begin
  Result := Self.address_id;
end;

function TUser.GetName: String;
begin
  Result := Self.first_name + ' ' + Self.surname;
end;

function TUser.GetUserID: integer;
begin
  Result := Self.user_id;
end;

procedure TUser.InsertUserRecord(objAddress: TAddress);
begin
  objAddress.InsertAddressRecord;
  Self.address_id := objAddress.GetAddressID;

  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('INSERT INTO [USER]');
    qryWaterBoard.SQL.Add
      ('(first_name, surname, email, username, [password], address_id)');
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

procedure TUser.UpdateUserRecord(UserID: integer; username: string);
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('UPDATE USER');
    qryWaterBoard.SQL.Add('SET username = :username');
    qryWaterBoard.SQL.Add('WHERE user_ID = :UserID');

    with qryWaterBoard.Parameters do
    begin
      ParamByName('username').Value := username;
      ParamByName('UserID').Value := UserID;
    end;

    qryWaterBoard.ExecSQL;
  end;
end;

function TUser.Validate(var Validation_Str: String): TArray<integer>;
var
  objValidate: Tvalidate;
  bAddToArray: Boolean;
begin
  objValidate := Tvalidate.Create;

  with objValidate do
  begin
    // Validation Result Key:
    // 1 = First Name
    // 2 = Surname
    // 3 = Email
    // 4 = Username
    // 5 = Password

    bAddToArray := False;

    // Validate First Name
    if CheckNull(Self.first_name) then
    begin
      Validation_Str := Validation_Str + 'Please enter your first name' + #13;
      bAddToArray := True;
    end;
    if CheckLength(Self.first_name, 20) then
    begin
      Validation_Str := Validation_Str +
        'The first name you entered is too long' + #13;
      bAddToArray := True;
    end;
    if not CheckStr(Self.first_name) then
    begin
      Validation_Str := Validation_Str +
        'Please remove any numbers from your first name' + #13;
      bAddToArray := True;
    end;
    if bAddToArray then
      AddToArray(Result, 1);

    bAddToArray := False;

    // Validate Surname
    if CheckNull(Self.surname) then
    begin
      Validation_Str := Validation_Str + 'Please enter your surname' + #13;
      bAddToArray := True;
    end;
    if CheckLength(Self.surname, 20) then
    begin
      Validation_Str := Validation_Str +
        'The surname you entered is too long' + #13;
      bAddToArray := True;
    end;
    if not CheckStr(Self.surname) then
    begin
      Validation_Str := Validation_Str +
        'Please remove any numbers from your surname' + #13;
      bAddToArray := True;
    end;
    if bAddToArray then
      AddToArray(Result, 2);

    bAddToArray := False;

    // Validate Email
    if CheckNull(Self.email) then
    begin
      Validation_Str := Validation_Str + 'Please enter your email' + #13;
      bAddToArray := True;
    end;
    if CheckLength(Self.email, 20) then
    begin
      Validation_Str := Validation_Str + 'The email entered is too long' + #13;
      bAddToArray := True;
    end;
    if not CheckEmail(Self.email) then
    begin
      Validation_Str := Validation_Str +
        'Please enter a valid Email address' + #13;
      bAddToArray := True;
    end;
    if bAddToArray then
      AddToArray(Result, 3);

    bAddToArray := False;

    // Validate Username
    if CheckNull(Self.username) then
    begin
      Validation_Str := Validation_Str + 'Please enter your username' + #13;
      bAddToArray := True;
    end;
    if CheckLength(Self.username, 20) then
    begin
      Validation_Str := Validation_Str +
        'The username entered is too long' + #13;
      bAddToArray := True;
    end;
    if bAddToArray then
      AddToArray(Result, 4);

    bAddToArray := False;

    // Validate Password
    if CheckNull(Self.password) then
    begin
      Validation_Str := Validation_Str + 'Please enter your password' + #13;
      bAddToArray := True;
    end;
    if bAddToArray then
      AddToArray(Result, 5);
  end;
end;

procedure TUser.AddToArray(var Input_Array: TArray<integer>; To_add: integer);
var
  ilength: integer;
begin
  SetLength(Input_Array, length(Input_Array) + 1);
  ilength := length(Input_Array);
  Input_Array[ilength - 1] := To_add;
end;

function TUser.CheckLogin: Boolean;
var
  objValidateLogin: Tvalidate;
  sDBHash: String;
  bReHash: Boolean;
begin
  objValidateLogin := Tvalidate.Create;
  Result := False;
  if not objValidateLogin.CheckUnique(Self.username, 'USER', 'username') then
  begin
    with dmWaterboard do
    begin
      qryWaterBoard.SQL.Clear;
      qryWaterBoard.SQL.Add
        ('SELECT user_id, first_name, surname, username, password, address_id FROM [USER] WHERE username = '
        + QuotedStr(Self.username));
      qryWaterBoard.Open;

      sDBHash := qryWaterBoard['password'];

      if TBCrypt.CheckPassword(Self.password, sDBHash, bReHash) then
      begin
        Result := True;

        Self.first_name := qryWaterBoard['first_name'];
        Self.surname := qryWaterBoard['surname'];
        Self.address_id := qryWaterBoard['address_id'];
        Self.user_id := qryWaterBoard['user_id'];
      end;
    end;
  end;
end;

end.
