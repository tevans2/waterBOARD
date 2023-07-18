unit frmGraphView_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, dmWaterBoard_u,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  VclTee.TeeGDIPlus, VclTee.TeEngine, VclTee.Series, VclTee.TeeProcs,
  VclTee.Chart, Vcl.StdCtrls, Vcl.ControlList, Vcl.Buttons, Math, Graph_u,
  clsUSER_u, clsValidation_u, clsWaterMeterReading_u, DateUtils;

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
  private
    { Private declarations }
    objGraph: TGraph;
    procedure PopulateDamGraph;
  public
    { Public declarations }
    OrigionForm: integer;
    DamID: integer;
    ActiveUser: TUser;
    objNewWaterMeterReading: TWaterMeterReading;
  end;

var
  frmGraphView: TfrmGraphView;

implementation

{$R *.dfm}

uses frmHomePage_u, frmDamList_u, frmMapView_u, frmHomeLoggedIn_u;

procedure TfrmGraphView.cbbTimeFrameChange(Sender: TObject);
begin
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
  iDamID: integer;
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

    cbbTimeFrame.Visible := False;
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

  if OrigionForm <> 3 then
  begin
    cbbTimeFrame.ItemIndex := 2;
    PopulateDamGraph;
  end;

end;

procedure TfrmGraphView.imgAddReadingHoverClick(Sender: TObject);
var
  rReading: Real;
  sReading: String;
  dDate: TDate;
  sDate: String;
  iAddressID: integer;
  fmt: TFormatSettings;
begin
  sReading := Inputbox('Water Meter Reading',
    'Enter water meter reading (kl):', '');
  try
    rReading := strtofloat(sReading);
  except
    Showmessage
      ('Please enter a valid water meter reading in kilo litres. Eg. 87,33 kl');
    Exit
  end;

  iAddressID := ActiveUser.GetAddressID;
  sDate := FormatDateTime('d/m/yyy', Now);

  fmt := TFormatSettings.Create;
  fmt.ShortDateFormat := 'd/m/yyyy';

  dDate := StrToDate(sDate, fmt);

  objNewWaterMeterReading := TWaterMeterReading.Create(rReading, dDate,
    iAddressID);
  objNewWaterMeterReading.InsertWaterMeterReading;

end;

procedure TfrmGraphView.imgAddReadingHoverMouseLeave(Sender: TObject);
begin
  imgAddReadingHover.Hide;
end;

procedure TfrmGraphView.imgAddReadingMouseEnter(Sender: TObject);
begin
  imgAddReadingHover.Show;
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

procedure TfrmGraphView.PopulateDamGraph;
var
  iCount: integer;
  dStartDate: TDate;
begin
  chrtGraph.Series[0].Clear;

  objGraph := TGraph.Create;
  dStartDate := objGraph.CalculateStartDate(cbbTimeFrame.ItemIndex);
  objGraph.SetupData(DamID, dStartDate);

  chrtGraph.Title.Text.Clear;
  chrtGraph.Title.Text.Add(objGraph.GetGraphTitle(DamID));

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

end.
