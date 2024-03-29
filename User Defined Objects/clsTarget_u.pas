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
    iTargetID: integer;

    constructor Create(target_set_date: TDate; target_value: Real;
      user_id: integer);
    procedure InsertTargetRecord;
    procedure UpdateTargetRecord;
    function CheckTargetDateInTable(user_id: integer): Boolean;
  end;

implementation

{ TTarget }

// Function to check if a target date already exists in the table for a specific user
function TTarget.CheckTargetDateInTable(user_id: integer): Boolean;
var
  DBDate: TDate;
  sDBDate, sTargetDate: String;
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    // Prepare the SQL statement for retrieving target set dates and target ids where the user id matches the input user id
    qryWaterBoard.SQL.Text :=
      'SELECT target_set_date, target_id FROM [TARGET] WHERE user_id= :user_id';
    // Assign the user id to the parameter in the SQL statement
    qryWaterBoard.Parameters.ParamByName('user_id').Value := user_id;

    qryWaterBoard.Open;

    // Assume that the target date does not exist in the table initially
    Result := False;

    // Iterate over the rows in the query result
    qryWaterBoard.First;
    while not qryWaterBoard.Eof do
    begin
      // Get the target set date from the current row
      DBDate := qryWaterBoard['target_set_date'];
      // Format the date to 'yyyy/mm'
      sDBDate := FormatDateTime('yyyy/mm', DBDate);
      sTargetDate := FormatDateTime('yyyy/mm', Self.target_set_date);

      // If the date in the table matches the target date, return True
      if sDBDate = sTargetDate then
      begin
        Result := True;
        // Store the target id from the current row
        iTargetID := qryWaterBoard['target_id'];
        exit
      end;
      // Move to the next row in the query result
      qryWaterBoard.Next;
    end;
  end;
end;

constructor TTarget.Create(target_set_date: TDate; target_value: Real;
  user_id: integer);
begin
  Self.target_set_date := target_set_date;
  Self.target_value := target_value;
  Self.user_id := user_id;
end;

procedure TTarget.InsertTargetRecord;
var
  rPrevTargetValue: Real;
  i: integer;
begin
  with dmWaterboard do
  begin
    qryWaterBoard.SQL.Clear;
    // Prepare the SQL statement for retrieving target set dates and target values where the user id matches the object's user id, ordered by the target set date
    qryWaterBoard.SQL.Add('SELECT target_set_date, target_value, user_id');
    qryWaterBoard.SQL.Add
      ('FROM TARGET WHERE user_id = :user_id ORDER BY target_set_date');
    // Assign the user id to the parameter in the SQL statement
    qryWaterBoard.Parameters.ParamByName('user_id').Value := user_id;

    qryWaterBoard.Open;

    // Move to the last record of the query result
    qryWaterBoard.Last;

    // Get the target value from the last record
    rPrevTargetValue := qryWaterBoard['target_value'];

    // Loop twice to insert two new target records
    for i := 1 to 2 do
    begin
      // Clear the SQL query
      qryWaterBoard.SQL.Clear;
      // Prepare the SQL statement for inserting a new record into the TARGET table
      qryWaterBoard.SQL.Add('INSERT INTO TARGET');
      qryWaterBoard.SQL.Add('(target_set_date, target_value, user_id)');
      qryWaterBoard.SQL.Add
        ('VALUES (:target_set_date, :target_value, :user_id)');
      with qryWaterBoard.Parameters do
      begin
        // Assign values to the parameters in the SQL statement
        ParamByName('target_set_date').Value := Self.target_set_date;
        ParamByName('target_value').Value := rPrevTargetValue;
        ParamByName('user_id').Value := Self.user_id;
      end;

      // Execute the SQL statement
      qryWaterBoard.ExecSQL;
      // Update the previous target value to the target value of the object
      rPrevTargetValue := Self.target_value;
    end;
  end;
end;

procedure TTarget.UpdateTargetRecord;
begin
  with dmWaterboard do
  begin // Update an existing target record in the database
    qryWaterBoard.SQL.Clear;
    qryWaterBoard.SQL.Add('UPDATE TARGET');
    qryWaterBoard.SQL.Add('SET target_value = :target_value');
    qryWaterBoard.SQL.Add('WHERE target_id = :target_id');

    with qryWaterBoard.Parameters do
    begin
      ParamByName('target_id').Value := iTargetID;
      ParamByName('target_value').Value := Self.target_value;
    end;

    qryWaterBoard.ExecSQL;
  end;
end;

end.
