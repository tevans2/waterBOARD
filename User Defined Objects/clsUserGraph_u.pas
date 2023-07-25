unit clsUserGraph_u;

interface

uses sysutils, DateUtils, dmWaterBoard_u;

type
  TUserGraph = class(TObject)
  private
    user_id: integer;
    address_id: integer;
    start_date: TDate;

  public
    constructor Create;
    procedure SetupUserData(address_id: integer; start_date: TDate);
    procedure SetupUserTargetData(user_id: integer; start_date: TDate);
    function CalculateStartDate(time_frame: integer): TDate;
    function GetMaxReading(address_id: integer): Real;
  end;

implementation

{ TUserGraph }

function TUserGraph.CalculateStartDate(time_frame: integer): TDate;
begin
  case time_frame of
    0:
      begin
        Result := IncMonth(now, -1);
      end;
    1:
      begin
        Result := IncMonth(now, -6);
      end;
    2:
      begin
        Result := IncYear(now, -1);
      end;
    3:
      begin
        Result := IncYear(now, -5);
      end;
    4:
      begin
        Result := IncYear(now, -10);
      end;
  end;
end;

constructor TUserGraph.Create;
begin

end;

function TUserGraph.GetMaxReading(address_id: integer): Real;
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('SELECT MAX(reading_in_kl) AS max_value');
    qryWaterBoard.SQL.Add('FROM WATER_METER_READING ');
    qryWaterBoard.SQL.Add('WHERE address_id = :address_id');
    qryWaterBoard.Parameters.ParamByName('address_id').Value := address_id;
    qryWaterBoard.Open;

    Result := qryWaterBoard['max_value'];
  end;
end;

procedure TUserGraph.SetupUserData(address_id: integer; start_date: TDate);
begin
  Self.address_id := address_id;
  Self.start_date := start_date;

  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('SELECT reading_date, reading_in_kl, address_id');
    qryWaterBoard.SQL.Add('FROM WATER_METER_READING ');
    qryWaterBoard.SQL.Add
      ('WHERE (address_id = :address_id) AND (reading_date >= #' +
      DateToStr(start_date) + '#)');

    qryWaterBoard.Parameters.ParamByName('address_id').Value := address_id;

    qryWaterBoard.Open;
  end;
end;

procedure TUserGraph.SetupUserTargetData(user_id: integer; start_date: TDate);
begin
  Self.user_id := user_id;
  Self.start_date := start_date;

  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('SELECT target_set_date, target_value, user_id');
    qryWaterBoard.SQL.Add('FROM TARGET ');
    qryWaterBoard.SQL.Add('WHERE (user_id = :user_id) AND (target_set_date >= #'
      + DateToStr(start_date) + '#)');

    qryWaterBoard.Parameters.ParamByName('user_id').Value := user_id;

    qryWaterBoard.Open;
  end;
end;

end.
