unit clsValidation_u;

interface

uses SysUtils, Vcl.Dialogs, dmWaterBoard_u;

type
  TValidate = Class
  private
  public
    constructor Create;
    function CheckNull(InputStr: String): Boolean;
    function CheckLength(InputStr: String; iLength: Integer): Boolean;
    function CheckStr(InputStr: String): Boolean;
    function CheckInt(InputStr: String): Boolean;
    function CheckDates(Date1, Date2: TDate): Boolean;
    function CheckEmail(InputStr: String): Boolean;
    function CheckCell(InputStr: String): Boolean;
    function CheckSame(Str1, Str2: String): Boolean;

    function CheckUnique(InputStr, DB_table, DB_field: String)
      : Boolean; overload;
    function CheckUnique(InputInt: Integer; DB_table, DB_field: String)
      : Boolean; overload;
    function CheckUnique(InputDate: TDate; DB_table, DB_field: String)
      : Boolean; overload;
  end;

implementation

{ Validate }

function TValidate.CheckCell(InputStr: String): Boolean;
var
  Valid: TValidate;
  iPos: Integer;
begin
  iPos := pos(' ', InputStr); // Ensures that there are no spcaes
  if iPos = 0 then
  begin
    Result := True;
    try // Checks that input is only integers
      strtoint(InputStr);
    except
      Result := False;
      exit
    end;

    if Length(InputStr) = 10 then // Checks length
      Result := True
    else
      Result := False;
  end
  else
    Result := False;
end;

function TValidate.CheckDates(Date1, Date2: TDate): Boolean;
begin
  if Date2 > Date1 then // Ensures date 1 comes before date 2
    Result := True
  else
    Result := False;
end;

function TValidate.CheckEmail(InputStr: String): Boolean;
var
  i, iAt, iDot, iAtPos, iDotPos, iPos: Integer;
  sIn: String;
begin
  sIn := UpperCase(InputStr);
  iAt := 0;
  iDot := 0;

  iPos := pos(' ', InputStr); // Ensures that there are no spaces
  if iPos = 0 then
  begin
    for i := 1 to Length(sIn) do
    begin
      if sIn[i] = '@' then // Ensures there is an @
        inc(iAt);
      if sIn[i] = '.' then // Ensures there is a '.'
        inc(iDot);
    end;

    if (iAt <> 1) or (iDot = 0) then
    begin
      Result := False;
      exit
    end
    else
    begin
      iAtPos := pos('@', sIn);

      if (iAtPos > 1) and (iAtPos < Length(sIn)) then
        Result := True
      else
      begin
        Result := False;
      end;
    end;

    for i := 1 to iDot do
    begin
      iDotPos := pos('.', sIn);
      if (iDotPos > 1) and (iDotPos < Length(sIn)) then
        Result := True
      else
      begin
        Result := False;
      end;
      Delete(sIn, iDotPos, 1);
    end;
  end
  else
    Result := False;
end;

function TValidate.CheckInt(InputStr: String): Boolean;
begin
  Result := True;
  try
    strtoint(InputStr);
  except
    Result := False;
  end;
end;

function TValidate.CheckLength(InputStr: String; iLength: Integer): Boolean;
begin
  if Length(InputStr) = iLength then
    Result := True
  else
    Result := False;
end;

function TValidate.CheckNull(InputStr: String): Boolean;
begin
  if InputStr = '' then
    Result := True
  else
    Result := False;
end;

function TValidate.CheckSame(Str1, Str2: String): Boolean;
begin
  if Str1 = Str2 then
    Result := True
  else
    Result := False;
end;

function TValidate.CheckStr(InputStr: String): Boolean;
var
  i: Integer;
begin
  InputStr := UpperCase(InputStr);
  Result := True;

  InputStr := StringReplace(InputStr, ' ', '', [rfReplaceAll]);
  // Removes spaces

  for i := 1 to Length(InputStr) do
    if not(InputStr[i] in ['A' .. 'Z']) then
      // Checks that input contains only string characters
      Result := False;
end;

function TValidate.CheckUnique(InputDate: TDate;
  DB_table, DB_field: String): Boolean;
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('SElECT ' + DB_field + ' FROM' + DB_table);

    if qryWaterBoard.Locate(DB_field, InputDate, []) then
      Result := False
    else if qryWaterBoard.Locate(DB_field, InputDate, []) = False then
      Result := True;
  end;
end;

function TValidate.CheckUnique(InputInt: Integer;
  DB_table, DB_field: String): Boolean;
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('SElECT ' + DB_field + ' FROM' + DB_table);

    if qryWaterBoard.Locate(DB_field, InputInt, []) then
      Result := False
    else if qryWaterBoard.Locate(DB_field, InputInt, []) = False then
      Result := True;
  end;
end;

function TValidate.CheckUnique(InputStr, DB_table, DB_field: String): Boolean;
vAR
  sSQL: String;
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    sSQL := 'SELECT ' + DB_field + ' FROM [' + DB_table + ']';
    qryWaterBoard.SQL.Add(sSQL);
    qryWaterBoard.Open;

    if qryWaterBoard.Locate(DB_field, InputStr, []) then
      Result := False
    else if qryWaterBoard.Locate(DB_field, InputStr, []) = False then
      Result := True;
  end;
end;

constructor TValidate.Create;
begin
end;

end.
