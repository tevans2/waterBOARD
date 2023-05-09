unit clsDamReading_u;

interface

uses
  System.SysUtils,
  System.StrUtils,
  REST.Types,
  REST.Client,
  dmWaterBoard_u,
  Vcl.Dialogs;

type
  TDamReading = class(TObject)
  private
    dam_id: integer;
    level_percent: Real;
    reading_date: TDateTime;

    function FetchReadingDate(HTMLTable: String): TDate;
    function FetchTable: String;
    function FetchDamLevels(HTMLTable: String): TArray<Real>;
  public
    constructor Create(dam_id: integer; level_percent: Real;
      reading_date: TDate); overload;
    constructor Create; overload;
    constructor CreateFromString(dam_id: integer; level_percent: Real;
      reading_date: TDate);

    procedure SetDamLevel;
    procedure SetDamID;
    procedure SetReadingDate;

    procedure InsertDamReading;
    procedure InsertDailyDamReadings;
  end;

implementation

{ TDamReading }

constructor TDamReading.Create(dam_id: integer; level_percent: Real;
  reading_date: TDate);
begin
  Self.dam_id := dam_id;
  Self.level_percent := level_percent;
  Self.reading_date := reading_date;
end;

constructor TDamReading.Create;
begin

end;

constructor TDamReading.CreateFromString(dam_id: integer; level_percent: Real;
  reading_date: TDate);
begin

end;

function TDamReading.FetchDamLevels(HTMLTable: String): TArray<Real>;
var
  tag, table, val_str, level_percent: string;
  i, j, tag_len, tag_start_pos, tag_end_pos: integer;
  arrDamData: TArray<Real>;
  iCount: integer;
  ReadingDate: TDate;
begin
  SetLength(arrDamData, 6);
  iCount := 0;

  table := HTMLTable;

  tag := '&lt;/td&gt;&lt;td style="height:31px;text-align:right;"&gt;';
  tag_len := length(tag);
  tag_start_pos := Pos(tag, table);

  // Get first dam (Berg River) data
  for i := 1 to 2 do
  begin
    tag_end_pos := PosEx('&lt;br&gt;', table, tag_start_pos);
    val_str := copy(table, tag_start_pos + tag_len, tag_end_pos - tag_start_pos
      - tag_len);

    tag_start_pos := PosEx(tag, table, tag_start_pos + tag_len);

    if i mod 2 = 0 then // Get only level percent (ommit capacity)
    begin
      level_percent := StringReplace(val_str, '.', ',', []);
      arrDamData[iCount] := strtofloat(level_percent);
      inc(iCount);
    end;
  end;

  // Get other 5 dam datas
  tag := '&lt;/td&gt;&lt;td style="text-align:right;"&gt;';
  tag_len := length(tag);
  tag_start_pos := Pos(tag, table);

  for j := 1 to 10 do
  begin
    tag_end_pos := PosEx('&lt;br&gt;', table, tag_start_pos);
    val_str := copy(table, tag_start_pos + tag_len, tag_end_pos - tag_start_pos
      - tag_len);

    tag_start_pos := PosEx(tag, table, tag_start_pos + tag_len);

    if j mod 2 = 0 then
    begin
      level_percent := StringReplace(val_str, '.', ',', []);
      arrDamData[iCount] := strtofloat(level_percent);
      inc(iCount);
    end;
  end;
  Result := arrDamData;
end;

function TDamReading.FetchReadingDate(HTMLTable: String): TDate;
var
  tag, val_str: String;
  tag_len, tag_start_pos, tag_end_pos: integer;
  fmt: TFormatSettings;
begin
  tag := 'Current Dam Water Levels - ';

  tag_len := length(tag);
  tag_start_pos := Pos(tag, HTMLTable);

  tag_end_pos := PosEx('&lt;/b&gt; &lt;/caption&gt;', HTMLTable, tag_start_pos);
  val_str := copy(HTMLTable, tag_start_pos + tag_len,
    tag_end_pos - tag_start_pos - tag_len);

  val_str := StringReplace(val_str, #$200B, '', [rfReplaceAll]);

  fmt := TFormatSettings.Create;
  fmt.ShortDateFormat := 'd/m/yyyy';

  Result := StrtoDate(val_str, fmt);
end;

function TDamReading.FetchTable: String;
var
  Client: TRESTClient;
  request: TRESTRequest;
  response: TCustomRESTResponse;
  table_begin_pos, table_end_pos: integer;
  page, table: String;
begin
  Client := TRESTClient.Create(nil);
  Client.BaseURL := 'https://www.capetown.gov.za/';

  request := TRESTRequest.Create(nil);
  request.Client := Client;
  request.Method := rmGET;
  request.Resource :=
    'Family%20and%20home/residential-utility-services/residential-water-and-sanitation-services/this-weeks-dam-levels';

  request.Execute;

  response := request.response;

  if response.Status.Success then
  begin
    page := response.Content;
    table_begin_pos := Pos('Current Dam Water Levels', page);
    table_end_pos := PosEx('Because each dam size is different', page,
      table_begin_pos);

    table := copy(page, table_begin_pos, table_end_pos);

    Result := table;
  end
  else
  begin
    Showmessage('Failed with ' + response.StatusText + ': ' + response.Content);
    Exit
  end;
end;

procedure TDamReading.InsertDailyDamReadings;
var
  arrDamLevels: TArray<Real>;
  sHTMLTable: String;
  i: integer;
begin
  sHTMLTable := FetchTable;
  arrDamLevels := FetchDamLevels(sHTMLTable);

  Self.reading_date := FetchReadingDate(sHTMLTable);
  for i := 0 to length(arrDamLevels) - 1 do
  begin
    Self.level_percent := arrDamLevels[i];
    Self.dam_id := i + 1;

    InsertDamReading;
  end;
end;

procedure TDamReading.InsertDamReading;
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.clear;
    qryWaterBoard.SQL.Add('INSERT INTO DAM_READING');
    qryWaterBoard.SQL.Add('(reading_date, level_percent, dam_id)');
    qryWaterBoard.SQL.Add('VALUES (:reading_date, :level_percent, :dam_id)');
    with qryWaterBoard.Parameters do
    begin
      ParamByName('reading_date').Value := Self.reading_date;
      ParamByName('level_percent').Value := Self.level_percent;
      ParamByName('dam_id').Value := Self.dam_id;
    end;

    qryWaterBoard.ExecSQL;
  end;
end;

procedure TDamReading.SetDamID;
begin

end;

procedure TDamReading.SetDamLevel;
begin

end;

procedure TDamReading.SetReadingDate;
begin

end;

end.
