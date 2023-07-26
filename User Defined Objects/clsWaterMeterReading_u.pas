unit clsWaterMeterReading_u;

interface

uses Sysutils, dmWaterBoard_u, clsValidation_u;

type
  TWaterMeterReading = class(TObject)
  private
    reading_date: TDateTime;
    reading_in_kl: Real;
    address_id: integer;
  public
    constructor Create(reading_in_kl: Real; reading_date: TDate;
      address_id: integer); overload;
    constructor Create; overload;

    procedure SetReadingDate(dDate: TDate);
    procedure SetReading(reading: Real);
    procedure SetAddressID(address_id: integer);

    procedure InsertWaterMeterReading;
    function ExtractFromFileLine(var line: String; var dDate: TDate): Real;
  end;

implementation

{ TWaterMeterReading }

constructor TWaterMeterReading.Create(reading_in_kl: Real; reading_date: TDate;
  address_id: integer);
begin
  Self.reading_in_kl := reading_in_kl;
  Self.reading_date := reading_date;
  Self.address_id := address_id;
end;

constructor TWaterMeterReading.Create;
begin

end;

function TWaterMeterReading.ExtractFromFileLine(var line: String;
  var dDate: TDate): Real;
var
  sLine: String;
  sReading: String;
  sDate: String;
  iPos: integer;
  objValidation: TValidate;
  fmt: TFormatSettings;
begin
  // FORMAT: 11,1 - yyyy/mm/dd

  sLine := line;
  iPos := pos('-', sLine);
  sReading := Copy(sLine, 0, iPos - 1);
  sReading := StringReplace(sReading, ' ', '', [rfReplaceAll]);

  Delete(sLine, 1, iPos + 1);

  sDate := StringReplace(sLine, ' ', '', [rfReplaceAll]);

  line := '';
  objValidation := TValidate.Create;

  if objValidation.CheckReal(sReading) then
    Result := strtofloat(sReading)
  else
  begin
    line := 'Invalid water meter reading';
  end;

  try
    fmt := TFormatSettings.Create;
    fmt.ShortDateFormat := 'yyyy/mm/dd';

    dDate := StrToDate(sDate, fmt);
  except
    line := 'Invalid date (format - yyyy/mm/dd)';
  end;

end;

procedure TWaterMeterReading.InsertWaterMeterReading;
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('INSERT INTO WATER_METER_READING');
    qryWaterBoard.SQL.Add('(reading_date, reading_in_kl, address_id)');
    qryWaterBoard.SQL.Add
      ('VALUES (:reading_date, :reading_in_kl, :address_id)');
    with qryWaterBoard.Parameters do
    begin
      ParamByName('reading_date').Value := Self.reading_date;
      ParamByName('reading_in_kl').Value := Self.reading_in_kl;
      ParamByName('address_id').Value := Self.address_id;
    end;

    qryWaterBoard.ExecSQL;
  end;
end;

procedure TWaterMeterReading.SetAddressID(address_id: integer);
begin
  Self.address_id := address_id;
end;

procedure TWaterMeterReading.SetReading(reading: Real);
begin
  Self.reading_in_kl := reading;
end;

procedure TWaterMeterReading.SetReadingDate(dDate: TDate);
begin
  Self.reading_date := dDate;
end;

end.
