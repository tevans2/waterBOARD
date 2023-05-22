unit Graph_u;

interface

uses sysutils, dmWaterBoard_u;

type
  TData = Array of array of real;
  TDateArray = Array of TDate;

  TGraph = class(TObject)
  private
    Data: TData;
    StartDate: TDate;
    EndDate: TDate;
    function GetDataFromTable(var DateArray: TDateArray): TData;
  public
    constructor Create();
    procedure DisplayGraph(StartDate, EndDate: TDate);
  end;

implementation

{ TGraph }

constructor TGraph.Create;
begin

end;

procedure TGraph.DisplayGraph(StartDate, EndDate: TDate);
var
  arrDates: TDateArray;
begin
  GetDataFromTable(arrDates);
end;

function TGraph.GetDataFromTable(var DateArray: TDateArray): TData;
var
  i, j: integer;
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add
      ('SELECT reading_date, level_percent FROM DAM_READING');
    qryWaterBoard.Open;

    i := 0;
    qryWaterBoard.First;
    while not qryWaterBoard.Eof do
    begin
      SetLength(DateArray, i + 1);
      DateArray[i] := qryWaterBoard['reading_date'];

      while (DateArray[i] = qryWaterBoard['reading_date']) do
      begin
        SetLength(Result, i + 1, 6);
        Result[i, j] := qryWaterBoard['level_percent'];
        inc(j);

        qryWaterBoard.Next;
      end;
      inc(i);
    end;
  end;
end;

end.
