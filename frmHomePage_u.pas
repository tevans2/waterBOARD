unit frmHomePage_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Math,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, frmDamList_u, frmMapView_u, frmLogin_u,
  frmSignUp_u, frmHomeLoggedIn_u, clsDamReading_u;

type
  TfrmHomePage = class(TForm)
    pnlHomePage: TPanel;
    Shape1: TShape;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Image1: TImage;
    Panel4: TPanel;
    imgDamList: TImage;
    imgMapView: TImage;
    imgSignUp: TImage;
    imgLogin: TImage;
    Shape2: TShape;
    imgDamListHover: TImage;
    imgMapViewHover: TImage;
    imgSignUpHover: TImage;
    imgLoginHover: TImage;
    procedure FormResize(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure imgLoginMouseEnter(Sender: TObject);
    procedure imgLoginHoverMouseLeave(Sender: TObject);
    procedure imgMapViewMouseEnter(Sender: TObject);
    procedure imgMapViewHoverMouseLeave(Sender: TObject);
    procedure imgSignUpMouseEnter(Sender: TObject);
    procedure imgSignUpHoverMouseLeave(Sender: TObject);
    procedure imgDamListMouseEnter(Sender: TObject);
    procedure imgDamListHoverMouseLeave(Sender: TObject);
    procedure imgDamListHoverClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgMapViewHoverClick(Sender: TObject);
    procedure imgLoginHoverClick(Sender: TObject);
    procedure imgSignUpHoverClick(Sender: TObject);
  private
    { Private declarations }
    objDamReading: TDamReading;
  public
    { Public declarations }
    MasterWindowState: TWindowState;
  end;

var
  frmHomePage: TfrmHomePage;

implementation

{$R *.dfm}

procedure TfrmHomePage.FormResize(Sender: TObject);
var
  Ratio: Real;
begin
  // GUI CODE BEGIN
  Ratio := min(ClientWidth / pnlHomePage.Width,
    ClientHeight / pnlHomePage.Height);
  pnlHomePage.ScaleBy(Trunc(Ratio * 100), 100);

  frmHomePage.MasterWindowState := Self.WindowState;
  // GUI CODE END
end;

procedure TfrmHomePage.FormShow(Sender: TObject);
begin
  // GUI CODE BEGIN
  WindowState := frmHomePage.MasterWindowState;
  frmHomeLoggedIn.bLoggedIn := False;
  // GUI CODE END
end;

procedure TfrmHomePage.imgDamListHoverClick(Sender: TObject);
var
  arrDamData: TArray<Real>;
  i: Integer;
  sOutput: String;
  dReadingDate: TDate;
  sHTMLTable: String;
begin
  // GUI CODE BEGIN
  frmDamList.Show;
  Self.Hide;
  // GUI CODE END

  objDamReading := TDamReading.Create;
  SetLength(arrDamData, 6);

  // Insert from STRING
//  objDamReading.ExtractFromString(dReadingDate,
//    '6-May-12,49.2,45,40.4,43.2,52.1,61.1,,');
//
//  objDamReading.InsertDailyDamReadings(dReadingDate, arrDamData);

  // Insert from WEB
  sHTMLTable := objDamReading.FetchTable;
  arrDamData[1] := strtofloat('87.6');
  arrDamData := objDamReading.FetchDamLevels(sHTMLTable);

  objDamReading.InsertDailyDamReadings(dReadingDate, arrDamData);

  for i := 0 to 5 do
    sOutput := sOutput + #13 + floattostr(arrDamData[i]);

  SHowmessage(sOutput);

end;

procedure TfrmHomePage.imgDamListHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN

  imgDamList.Visible := True;
  imgDamListHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmHomePage.imgLoginHoverClick(Sender: TObject);
begin
  // GUI CODE BEGIN

  frmLogin.Show;
  // GUI CODE END
end;

procedure TfrmHomePage.imgLoginHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgLogin.Visible := True;
  imgLoginHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmHomePage.imgLoginMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgLogin.Visible := False;
  imgLoginHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmHomePage.imgMapViewHoverClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  frmMapView.Show;
  Self.Hide;
  // GUI CODE END
end;

procedure TfrmHomePage.imgMapViewHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgMapView.Visible := True;
  imgMapViewHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmHomePage.imgMapViewMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgMapView.Visible := False;
  imgMapViewHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmHomePage.imgSignUpHoverClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  frmSignUp.Show;
  // GUI CODE END
end;

procedure TfrmHomePage.imgSignUpHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgSignUp.Visible := True;
  imgSignUpHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmHomePage.imgSignUpMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgSignUp.Visible := False;
  imgSignUpHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmHomePage.imgDamListMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgDamList.Visible := False;
  imgDamListHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmHomePage.Panel1Resize(Sender: TObject);
var
  Ratio: Real;
begin
  // GUI CODE BEGIN
  Ratio := min(Panel1.Width / Panel4.Width, Panel1.Height / Panel4.Height);
  Panel4.ScaleBy(Trunc(Ratio * 100), 100);

  with Panel4 do
  begin
    Left := (Panel1.Width - Width) div 2;
    Top := (Panel1.Height - Height) div 2;
  end;
  // GUI CODE END
end;

end.
