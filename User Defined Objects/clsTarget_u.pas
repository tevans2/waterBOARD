unit clsTarget_u;

interface

uses SysUtils, dmWaterboard_u, clsValidation_u;

type
  TTarget = class(TObject)
  private
    target_set_date: TDateTime;
    target_value: Real;
    user_id: integer;

  public
    constructor Create(target_set_date: TDate; target_value: Real;
      user_id: integer);
    procedure InsertTargetRecord;
  end;

implementation

{ TTarget }

constructor TTarget.Create(target_set_date: TDate; target_value: Real;
  user_id: integer);
begin
  Self.target_set_date := target_set_date;
  Self.target_value := target_value;
  Self.user_id := user_id;
end;

procedure TTarget.InsertTargetRecord;
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('INSERT INTO TARGET');
    qryWaterBoard.SQL.Add('(target_set_date, target_value, user_id)');
    qryWaterBoard.SQL.Add
      ('VALUES (:target_set_date, :target_value, :user_id)');
    with qryWaterBoard.Parameters do
    begin
      ParamByName('target_set_date').Value := Self.target_set_date;
      ParamByName('target_value').Value := Self.target_value;
      ParamByName('user_id').Value := Self.user_id;
    end;

    qryWaterBoard.ExecSQL;
  end;
end;

end.
