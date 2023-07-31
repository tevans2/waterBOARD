unit frmGraphView_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, dmWaterBoard_u,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  VclTee.TeeGDIPlus, VclTee.TeEngine, VclTee.Series, VclTee.TeeProcs,
  VclTee.Chart, Vcl.StdCtrls, Vcl.ControlList, Vcl.Buttons, Math, clsDamGraph_u,
  clsUSER_u, clsValidation_u, clsWaterMeterReading_u, clsTarget_u,
  clsUserGraph_u, DateUtils;

type
  TfrmGraphView = class(TForm)
    pnlHomePage: TPanel;
    Panel1: TPanel;
    shpGraph: TShape;
    Panel2: TPanel;
    Shape1: TShape;
    Panel3: TPanel;
    imgLogoIcon: TImage;
    imgBackArrow: TImage;
    chrtGraph: TChart;
    imgBackArrowHover: TImage;
    imgHome_hover: TImage;
    imgHome: TImage;
    cbbTimeFrame: TComboBox;
    imgAddReading: TImage;
    imgAddTarget: TImage;
    Panel4: TPanel;
    imgAddReadingHover: TImage;
    imgAddTargetHover: TImage;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure imgBackArrowMouseEnter(Sender: TObject);
    procedure imgHomeMouseEnter(Sender: TObject);
    procedure imgBackArrowHoverMouseLeave(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure imgBackArrowHoverClick(Sender: TObject);
    procedure imgHome_hoverMouseLeave(Sender: TObject);
    procedure imgHome_hoverClick(Sender: TObject);
    procedure imgAddTargetMouseEnter(Sender: TObject);
    procedure imgAddTargetHoverMouseLeave(Sender: TObject);
    procedure imgAddReadingHoverMouseLeave(Sender: TObject);
    procedure imgAddReadingMouseEnter(Sender: TObject);
    procedure cbbTimeFrameChange(Sender: TObject);
    procedure imgAddReadingHoverClick(Sender: TObject);
    procedure imgAddTargetHoverClick(Sender: TObject);
  private
    { Private declarations }
    objDamGraph: TDamGraph;
    objUserGraph: TUserGraph;
    objTargetGraph: TUserGraph;

    procedure PopulateDamGraph;
    procedure PopulateUserGraph;
    procedure PopulateTargetGraph;

    function MyMessageDlg(CONST Msg: string; DlgTypt: TmsgDlgType;
      button: TMsgDlgButtons; Caption: ARRAY OF string;
      dlgcaption: string): Integer;
  public
    { Public declarations }
    OrigionForm: Integer;
    DamID: Integer;
    ActiveUser: TUser;
    objValidation: TValidate;
    objNewWaterMeterReading: TWaterMeterReading;
    objNewTarget: TTarget;

  end;

var
  frmGraphView: TfrmGraphView;

implementation

{$R *.dfm}

uses frmHomePage_u, frmDamList_u, frmMapView_u, frmHomeLoggedIn_u;

procedure TfrmGraphView.cbbTimeFrameChange(Sender: TObject);
begin
  if OrigionForm = 3 then
  begin
    PopulateUserGraph;
  end
  else
    PopulateDamGraph;
end;

procedure TfrmGraphView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // GUI CODE BEGIN
  frmHomePage.Close;
  // GUI CODE END
end;

procedure TfrmGraphView.FormResize(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgHome_hover.Left := imgHome.Left;
  imgHome_hover.Top := imgHome.Top;

  imgBackArrowHover.Left := imgBackArrow.Left;
  imgBackArrowHover.Top := imgBackArrow.Top;

  imgAddReadingHover.Left := imgAddReading.Left;
  imgAddTargetHover.Top := imgAddTarget.Top;

  frmHomePage.MasterWindowState := Self.WindowState;
  // GUI CODE END
end;

procedure TfrmGraphView.FormShow(Sender: TObject);
var
  dStartDate, dEndDate: TDate;
  iDamID: Integer;
begin
  // GUI CODE BEGIN
  imgHome_hover.Visible := False;
  imgBackArrowHover.Visible := False;
  imgAddReadingHover.Visible := False;
  imgAddTargetHover.Visible := False;

  if OrigionForm = 3 then // If previous form is frmHomeLoggedIn
  begin
    imgAddReading.Visible := True;
    imgAddReadingHover.Visible := False;
    imgAddTarget.Visible := True;
    imgAddTargetHover.Visible := False;
  end
  else
  begin // If previous form is frmDamList or frmMapView
    imgAddReading.Visible := False;
    imgAddReadingHover.Visible := False;
    imgAddTarget.Visible := False;
    imgAddTargetHover.Visible := False;

    cbbTimeFrame.Visible := True;
  end;

  WindowState := frmHomePage.MasterWindowState;
  // GUI CODE END

  if OrigionForm = 3 then // If previous form is frmHomeLoggedIn
  begin
    cbbTimeFrame.ItemIndex := 1;
    PopulateUserGraph;
  end
  else
  begin // If previous form is frmDamList or frmMapView
    cbbTimeFrame.ItemIndex := 2;
    PopulateDamGraph;
    chrtGraph.Refresh;
  end;

  objValidation := TValidate.Create;

end;

procedure TfrmGraphView.imgAddReadingHoverClick(Sender: TObject);
var
  rReading: Real;
  sReading: String;
  dDate: TDate;
  sDate: String;
  iAddressID: Integer;
  fmt: TFormatSettings;
  txtInput: TextFile;
  openDialog: TOpenDialog;
  sLine: String;
  iLineCount: Integer;
begin

  iAddressID := ActiveUser.GetAddressID;

  case MyMessageDlg('Caption', TmsgDlgType.mtInformation, [mbYes, mbNo],
    ['Upload from file', 'Enter manually'], 'TGesttg') of

    mrYes:
      begin
        // Create a dialog to open files
        openDialog := TOpenDialog.Create(Self);
        // Filter to only show text files
        openDialog.Filter := 'Text files only|*.txt';
        // Set title of the dialog
        openDialog.Title := 'Please select water meter reading input file';
        // Check if user selected a file and clicked 'Open'
        if openDialog.Execute then
        begin
          // Create a new Water Meter Reading object
          objNewWaterMeterReading := TWaterMeterReading.Create;
          // Initialize line count to 0
          iLineCount := 0;

          // Assign the selected file to txtInput
          AssignFile(txtInput, openDialog.FileName);
          // Open the assigned file
          Reset(txtInput);
          // Loop until the end of the file
          while not Eof(txtInput) do
          begin
            // Increment line counter
            inc(iLineCount);
            // Read a line from the file and assign it to sLine
            ReadLn(txtInput, sLine);

            // Extract reading and date from the line
            rReading := objNewWaterMeterReading.ExtractFromFileLine
              (sLine, dDate);

            // Check if line is empty
            if sLine = '' then
            begin
              // Set properties of the water meter reading object
              with objNewWaterMeterReading do
              begin
                // Set reading date
                SetReadingDate(dDate);
                // Set reading
                SetReading(rReading);
                // Set address ID
                SetAddressID(iAddressID);

                // Insert the reading into database
                InsertWaterMeterReading;

                // Update user's water usage graph
                PopulateUserGraph;
              end;
            end
            else
            begin
              // If line is not empty, display an error message with the line number
              ShowMessage(' on line ' + iLineCount.ToString);
              // Exit the program
              Exit
            end;
          end;
        end;
      end;

    mrNo:
      begin
        // Ask the user for a water meter reading using an input box
        sReading := Inputbox('Water Meter Reading',
          'Enter water meter reading (kl):', '');

        // Check if the entered reading is a real number using the CheckReal method of the validation object
        if objValidation.CheckReal(sReading) then
        begin
          // Get the current date and format it as 'yyyy/mm/dd'
          sDate := FormatDateTime('yyyy/mm/dd', Now);

          // Create a TFormatSettings instance to specify the date format
          fmt := TFormatSettings.Create;
          fmt.ShortDateFormat := 'yyyy/mm/dd';

          // Convert the date string to a TDateTime instance using the specified format
          dDate := StrToDate(sDate, fmt);

          // Convert the reading string to a float
          rReading := strtofloat(sReading);

          // Create a new water meter reading with the entered reading, the current date, and the address ID
          objNewWaterMeterReading := TWaterMeterReading.Create(rReading, dDate,
            iAddressID);

          // Insert the new water meter reading into the database
          objNewWaterMeterReading.InsertWaterMeterReading;

          // Refresh the user graph to include the new reading
          PopulateUserGraph;
        end
        else if sReading <> '' then
        begin
          // If the entered reading is not empty and not a real number, show an error message
          ShowMessage
            ('Please enter a valid water meter reading in kilo litres. Eg. 7,33 kl');
          Exit
        end;
      end;
  end;
end;

procedure TfrmGraphView.imgAddReadingHoverMouseLeave(Sender: TObject);
begin
  imgAddReadingHover.Hide;
end;

procedure TfrmGraphView.imgAddReadingMouseEnter(Sender: TObject);
begin
  imgAddReadingHover.Show;
end;

procedure TfrmGraphView.imgAddTargetHoverClick(Sender: TObject);
var
  rTarget: Real;
  sTarget: String;
  dDate: TDate;
  sDate: String;
  iUserID: Integer;
  fmt: TFormatSettings;
begin
  // Request the user to input their target water usage using an input box
  sTarget := Inputbox('Target Water Usage',
    'Update your monthly water usage target (kl):', '');

  // Check if the entered target is a real number using the CheckReal method of the validation object
  if objValidation.CheckReal(sTarget) then
  begin
    // Get the user ID of the currently active user
    iUserID := ActiveUser.GetUserID;

    // Get the current date and format it as 'yyyy/mm/dd'
    sDate := FormatDateTime('yyyy/mm/dd', Now);

    // Create a TFormatSettings instance to specify the date format
    fmt := TFormatSettings.Create;
    fmt.ShortDateFormat := 'yyyy/mm/dd';

    // Convert the date string to a TDateTime instance using the specified format
    dDate := StrToDate(sDate, fmt);

    // Convert the target string to a float
    rTarget := strtofloat(sTarget);

    // Create a new target with the entered target, the current date, and the user ID
    objNewTarget := TTarget.Create(dDate, rTarget, iUserID);

    // Check if a target for the current date already exists in the table for this user
    if objNewTarget.CheckTargetDateInTable(iUserID) then
      // If a target already exists, update the record
      objNewTarget.UpdateTargetRecord
    else
      // If no target exists, insert a new record
      objNewTarget.InsertTargetRecord;

    // Refresh the user graph to include the new target
    PopulateUserGraph;
  end
  else
  begin
    // If the entered target is not a real number, show an error message
    ShowMessage
      ('Please enter a valid monthly water usage target in kilo litres. Eg. 6,33 kl');
    Exit
  end;
end;

procedure TfrmGraphView.imgAddTargetHoverMouseLeave(Sender: TObject);
begin
  imgAddTargetHover.Hide;
end;

procedure TfrmGraphView.imgAddTargetMouseEnter(Sender: TObject);
begin
  imgAddTargetHover.Show;
end;

procedure TfrmGraphView.imgBackArrowHoverClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  case OrigionForm of
    1:
      frmDamList.Show;
    2:
      frmMapView.Show;
    3:
      frmHomeLoggedIn.Show;

  end;

  Self.Hide;
  // GUI CODE END
end;

procedure TfrmGraphView.imgBackArrowHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgBackArrowHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmGraphView.imgBackArrowMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgBackArrowHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmGraphView.imgHomeMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgHome_hover.Visible := True;
  // GUI CODE END
end;

procedure TfrmGraphView.imgHome_hoverClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  case frmHomeLoggedIn.bLoggedIn of
    True:
      frmHomeLoggedIn.Show;
    False:
      frmHomePage.Show;
  end;

  Self.Hide;
  // GUI CODE END
end;

procedure TfrmGraphView.imgHome_hoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgHome_hover.Visible := False;
  // GUI CODE END
end;

function TfrmGraphView.MyMessageDlg(const Msg: string; DlgTypt: TmsgDlgType;
  button: TMsgDlgButtons; Caption: array of string; dlgcaption: string)
  : Integer;
var
  aMsgdlg: TForm;
  i: Integer;
  Dlgbutton: Tbutton;
  Captionindex: Integer;
begin
  // Create a message dialog with specified message, type, and buttons
  aMsgdlg := createMessageDialog(Msg, DlgTypt, button);

  // Set the caption of the message dialog
  aMsgdlg.Caption := dlgcaption;

  // Set the BiDiMode property to RightToLeft for languages that are written from right to left
  aMsgdlg.BiDiMode := bdRightToLeft;

  // Initialize the index to use for setting button captions
  Captionindex := 0;

  // Loop through all components in the dialog
  for i := 0 to aMsgdlg.componentcount - 1 Do
  begin
    // Check if the component is a button
    if (aMsgdlg.components[i] is Tbutton) then
    Begin
      // Cast the component to a TButton
      Dlgbutton := Tbutton(aMsgdlg.components[i]);

      // Check if there is a caption for this button
      if Captionindex <= High(Caption) then
      begin
        // Set the button caption and width
        Dlgbutton.Caption := Caption[Captionindex];
        Dlgbutton.Width := 200;

        // Special case for the fourth button
        if i = 3 then
          // Move the button to the left
          Dlgbutton.Left := 250;
      end;

      // Increment the caption index for the next button
      inc(Captionindex);
    end;
  end;

  // Set the dialog width
  aMsgdlg.Width := 480;

  // Show the dialog and return the modal result
  Result := aMsgdlg.Showmodal;
end;

procedure TfrmGraphView.PopulateDamGraph;
var
  iCount: Integer;
  dStartDate: TDate;
begin
  // Clear the first series of data in the chart
  chrtGraph.Series[0].Clear;

  // Make the first series visible and the second and third series invisible
  chrtGraph.Series[0].Visible := True;
  chrtGraph.Series[1].Visible := False;
  chrtGraph.Series[2].Visible := False;

  // Create an instance of TDamGraph
  objDamGraph := TDamGraph.Create;

  // Calculate the start date based on the selected time frame in a combo box
  dStartDate := objDamGraph.CalculateStartDate(cbbTimeFrame.ItemIndex);

  // Set up the dam data for the chart
  objDamGraph.SetupDamData(DamID, dStartDate);

  // Clear the title text of the chart and set a new title
  chrtGraph.Title.text.Clear;
  chrtGraph.Title.text.Add(objDamGraph.GetGraphTitle(DamID));

  // Access the data module dmWaterboard
  with dmWaterboard do
  begin
    // Start at the first record of the qryWaterBoard dataset
    qryWaterBoard.First;

    // Loop through all records in the dataset
    while not qryWaterBoard.Eof do
    begin
      // Add each record to the chart as a data point in the first series
      chrtGraph.Series[0].AddXY(qryWaterBoard['reading_date'],
        qryWaterBoard['level_percent'], '', clTeeColor);

      // Move to the next record
      qryWaterBoard.Next;
    end;
  end;
end;

procedure TfrmGraphView.PopulateTargetGraph;
var
  iCount: Integer;
  dStartDate: TDate;
begin
  // Clear the third series of data in the chart
  chrtGraph.Series[2].Clear;

  // Create a new instance of TUserGraph
  objUserGraph := TUserGraph.Create;

  // Calculate the start date based on the selected time frame in a combo box
  dStartDate := objUserGraph.CalculateStartDate(cbbTimeFrame.ItemIndex);

  // Set up the user target data for the chart
  objUserGraph.SetupUserTargetData(ActiveUser.GetUserID, dStartDate);

  // Access the data module dmWaterboard
  with dmWaterboard do
  begin
    // Start at the first record of the qryWaterBoard dataset
    qryWaterBoard.First;

    // Loop through all records in the dataset
    while not qryWaterBoard.Eof do
    begin
      // Add each record to the chart as a data point in the third series
      chrtGraph.Series[2].AddXY(qryWaterBoard['target_set_date'],
        qryWaterBoard['target_value'], '', clTeeColor);

      // Move to the next record
      qryWaterBoard.Next;
    end;
  end;
end;


procedure TfrmGraphView.PopulateUserGraph;
var
  iCount: Integer;
  dStartDate: TDate;
  rMaxReading: Real;
begin
  // Clear the data points for the second series in the chart
  chrtGraph.Series[1].Clear;

  // Hide the first series in the chart
  chrtGraph.Series[0].Visible := False;
  // Show the second and third series in the chart
  chrtGraph.Series[1].Visible := True;
  chrtGraph.Series[2].Visible := True;

  // Set the start position of the left axis in the chart to 0
  chrtGraph.LeftAxis.StartPosition := 0;

  // Create a new user graph
  objUserGraph := TUserGraph.Create;
  // Calculate the start date based on the selected time frame
  dStartDate := objUserGraph.CalculateStartDate(cbbTimeFrame.ItemIndex);
  // Setup the user data for the active user since the start date
  objUserGraph.SetupUserData(ActiveUser.GetAddressID, dStartDate);

  // Clear the chart title
  chrtGraph.Title.text.Clear;
  // Set the chart title to the active user's name and their water usage
  chrtGraph.Title.text.Add(ActiveUser.GetName + ' - Water Usage');

  // Start accessing the waterboard data
  with dmWaterboard do
  begin
    // Go to the first record in the dataset
    qryWaterBoard.First;
    // Loop through all the records in the dataset
    while not qryWaterBoard.Eof do
    begin
      // Add the water reading for the date as a point in the second series in the chart
      chrtGraph.Series[1].AddXY(qryWaterBoard['reading_date'],
        qryWaterBoard['reading_in_kl'], '', clTeeColor);
      // Move to the next record in the dataset
      qryWaterBoard.Next;
    end;
  end;

  // Populate the target graph
  PopulateTargetGraph;
end;

end.
