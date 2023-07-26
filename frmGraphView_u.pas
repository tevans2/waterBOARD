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

  if OrigionForm = 3 then
  begin
    imgAddReading.Visible := True;
    imgAddReadingHover.Visible := False;
    imgAddTarget.Visible := True;
    imgAddTargetHover.Visible := False;
  end
  else
  begin
    imgAddReading.Visible := False;
    imgAddReadingHover.Visible := False;
    imgAddTarget.Visible := False;
    imgAddTargetHover.Visible := False;

    cbbTimeFrame.Visible := True;
  end;

  WindowState := frmHomePage.MasterWindowState;
  // GUI CODE END

  if OrigionForm = 3 then
  begin
    cbbTimeFrame.ItemIndex := 1;
    PopulateUserGraph;
  end
  else
  begin
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
        openDialog := TOpenDialog.Create(Self);
        openDialog.Filter := 'Text files only|*.txt';
        openDialog.Title := 'Please select water meter reading input file';
        if openDialog.Execute then
        begin
          objNewWaterMeterReading := TWaterMeterReading.Create;
          iLineCount := 0;

          AssignFile(txtInput, openDialog.FileName);
          Reset(txtInput);
          while not Eof(txtInput) do
          begin
            inc(iLineCount);
            ReadLn(txtInput, sLine);

            rReading := objNewWaterMeterReading.ExtractFromFileLine
              (sLine, dDate);

            if sLine = '' then
            begin
              with objNewWaterMeterReading do
              begin
                SetReadingDate(dDate);
                SetReading(rReading);
                SetAddressID(iAddressID);

                InsertWaterMeterReading;

                PopulateUserGraph;
              end;
            end
            else
            begin
              ShowMessage(' on line ' + iLineCount.ToString);
              Exit
            end;
          end;
        end;
      end;

    mrNo:
      begin
        sReading := Inputbox('Water Meter Reading',
          'Enter water meter reading (kl):', '');

        if objValidation.CheckReal(sReading) then
        begin
          sDate := FormatDateTime('yyyy/mm/dd', Now);

          fmt := TFormatSettings.Create;
          fmt.ShortDateFormat := 'yyyy/mm/dd';

          dDate := StrToDate(sDate, fmt);

          rReading := strtofloat(sReading);

          objNewWaterMeterReading := TWaterMeterReading.Create(rReading, dDate,
            iAddressID);
          objNewWaterMeterReading.InsertWaterMeterReading;

          PopulateUserGraph;
        end
        else if sReading <> '' then
        begin
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

  sTarget := Inputbox('Target Water Usage',
    'Update your monthly water usage target (kl):', '');

  if objValidation.CheckReal(sTarget) then
  begin
    iUserID := ActiveUser.GetUserID;

    sDate := FormatDateTime('yyyy/mm/dd', Now);

    fmt := TFormatSettings.Create;
    fmt.ShortDateFormat := 'yyyy/mm/dd';

    dDate := StrToDate(sDate, fmt);

    rTarget := strtofloat(sTarget);

    objNewTarget := TTarget.Create(dDate, rTarget, iUserID);

    if objNewTarget.CheckTargetDateInTable then
      objNewTarget.UpdateTargetRecord
    else
      objNewTarget.InsertTargetRecord;

    PopulateUserGraph;
  end
  else
  begin
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
  aMsgdlg := createMessageDialog(Msg, DlgTypt, button);
  aMsgdlg.Caption := dlgcaption;
  aMsgdlg.BiDiMode := bdRightToLeft;
  Captionindex := 0;
  for i := 0 to aMsgdlg.componentcount - 1 Do
  begin
    if (aMsgdlg.components[i] is Tbutton) then
    Begin
      Dlgbutton := Tbutton(aMsgdlg.components[i]);
      if Captionindex <= High(Caption) then
      begin
        Dlgbutton.Caption := Caption[Captionindex];
        Dlgbutton.Width := 200;
        if i = 3 then
          Dlgbutton.Left := 250;

      end;
      inc(Captionindex);
    end;
  end;

  aMsgdlg.Width := 480;
  Result := aMsgdlg.Showmodal;
end;

procedure TfrmGraphView.PopulateDamGraph;
var
  iCount: Integer;
  dStartDate: TDate;
begin
  chrtGraph.Series[0].Clear;
  chrtGraph.Series[0].Visible := True;
  chrtGraph.Series[1].Visible := False;
  chrtGraph.Series[2].Visible := False;

  objDamGraph := TDamGraph.Create;
  dStartDate := objDamGraph.CalculateStartDate(cbbTimeFrame.ItemIndex);
  objDamGraph.SetupDamData(DamID, dStartDate);

  chrtGraph.Title.text.Clear;
  chrtGraph.Title.text.Add(objDamGraph.GetGraphTitle(DamID));

  with dmWaterboard do
  begin
    qryWaterBoard.First;
    while not qryWaterBoard.Eof do
    begin
      chrtGraph.Series[0].AddXY(qryWaterBoard['reading_date'],
        qryWaterBoard['level_percent'], '', clTeeColor);
      qryWaterBoard.Next;
    end;
  end;
end;

procedure TfrmGraphView.PopulateTargetGraph;
var
  iCount: Integer;
  dStartDate: TDate;
begin
  chrtGraph.Series[2].Clear;

  objUserGraph := TUserGraph.Create;
  dStartDate := objUserGraph.CalculateStartDate(cbbTimeFrame.ItemIndex);
  objUserGraph.SetupUserTargetData(ActiveUser.GetUserID, dStartDate);

  with dmWaterboard do
  begin
    qryWaterBoard.First;
    while not qryWaterBoard.Eof do
    begin
      chrtGraph.Series[2].AddXY(qryWaterBoard['target_set_date'],
        qryWaterBoard['target_value'], '', clTeeColor);
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
  chrtGraph.Series[1].Clear;

  chrtGraph.Series[0].Visible := False;
  chrtGraph.Series[1].Visible := True;
  chrtGraph.Series[2].Visible := True;

  chrtGraph.LeftAxis.StartPosition := 0;

  // rMaxReading := objUserGraph.GetMaxReading(ActiveUser.GetAddressID);
  // rMaxReading := rMaxReading + trunc(rMaxReading / 3);
  // chrtGraph.LeftAxis.EndPosition := rMaxReading;

  objUserGraph := TUserGraph.Create;
  dStartDate := objUserGraph.CalculateStartDate(cbbTimeFrame.ItemIndex);
  objUserGraph.SetupUserData(ActiveUser.GetAddressID, dStartDate);

  chrtGraph.Title.text.Clear;
  chrtGraph.Title.text.Add(ActiveUser.GetName + ' - Water Usage');

  with dmWaterboard do
  begin
    qryWaterBoard.First;
    while not qryWaterBoard.Eof do
    begin
      chrtGraph.Series[1].AddXY(qryWaterBoard['reading_date'],
        qryWaterBoard['reading_in_kl'], '', clTeeColor);
      qryWaterBoard.Next;
    end;
  end;

  PopulateTargetGraph;
end;

end.
