unit clsWaterMeterReading_u;

interface

uses Sysutils, dmWaterBoard_u;

type
  TWaterMeterReading = class(TObject)
  private
    reading_date: TDateTime;
    reading_in_kl: Real;
    address_id: integer;
  public
    constructor Create(reading_in_kl: Real; reading_date: TDate;
      address_id: integer);
    procedure InsertWaterMeterReading;
  end;

implementation

{ TWaterMeterReading }

constructor TWaterMeterReading.Create(reading_in_kl: Real; reading_date: TDate;
  address_id: integer);
begin
  Self.reading_in_kl := reading_in_kl;
  Self.reading_date :=  reading_date;
  Self.address_id := address_id;
end;

procedure TWaterMeterReading.InsertWaterMeterReading;
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('INSERT INTO WATER_METER_READING');
    qryWaterBoard.SQL.Add('(reading_date, reading_in_kl, address_id)');
    qryWaterBoard.SQL.Add('VALUES (:reading_date, :reading_in_kl, :address_id)');
    with qryWaterBoard.Parameters do
    begin
      ParamByName('reading_date').Value := Self.reading_date;
      ParamByName('reading_in_kl').Value := Self.reading_in_kl;
      ParamByName('address_id').Value := Self.address_id;
    end;

    qryWaterBoard.ExecSQL;
  end;
end;

end.
