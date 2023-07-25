unit frmHomeLoggedIn_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Math, frmDamList_u, frmMapView_u, frmGraphView_u;

type
  TfrmHomeLoggedIn = class(TForm)
    pnlHomePage: TPanel;
    Panel1: TPanel;
    Shape2: TShape;
    Panel4: TPanel;
    imgDamList: TImage;
    imgMapView: TImage;
    imgUserStats: TImage;
    imgDamListHover: TImage;
    imgMapViewHover: TImage;
    imgUserStatsHover: TImage;
    Panel2: TPanel;
    Shape1: TShape;
    Panel3: TPanel;
    Image1: TImage;
    imgSignOut: TImage;
    imgSignOut_hover: TImage;
    procedure FormResize(Sender: TObject);
    procedure ResizeRePos(MainImage, MovingImage: TImage);
    procedure imgUserStatsMouseEnter(Sender: TObject);
    procedure imgMapViewMouseEnter(Sender: TObject);
    procedure imgDamListMouseEnter(Sender: TObject);
    procedure imgDamListHoverMouseLeave(Sender: TObject);
    procedure imgMapViewHoverMouseLeave(Sender: TObject);
    procedure imgUserStatsHoverMouseLeave(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Panel1Resize(Sender: TObject);
    procedure imgDamListHoverClick(Sender: TObject);
    procedure imgMapViewHoverClick(Sender: TObject);
    procedure imgUserStatsHoverClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgSignOutMouseEnter(Sender: TObject);
    procedure imgSignOut_hoverMouseLeave(Sender: TObject);
    procedure imgSignOut_hoverClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    bLoggedIn: Boolean;
  end;

var
  frmHomeLoggedIn: TfrmHomeLoggedIn;

implementation

{$R *.dfm}

uses frmHomePage_u;

procedure TfrmHomeLoggedIn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmHomePage.Close;
end;

procedure TfrmHomeLoggedIn.FormResize(Sender: TObject);
begin
  // GUI CODE BEGIN
  ResizeRePos(imgDamList, imgDamListHover);
  ResizeRePos(imgMapView, imgMapViewHover);
  ResizeRePos(imgUserStats, imgUserStatsHover);

  frmHomePage.MasterWindowState := Self.WindowState;
  // GUI CODE END
end;

procedure TfrmHomeLoggedIn.FormShow(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgSignOut_hover.Visible := False;
  WindowState := frmHomePage.MasterWindowState;
  // GUI CODE END
end;

procedure TfrmHomeLoggedIn.imgDamListHoverClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  frmDamList.Show;
  Self.Hide;
  // GUI CODE END
end;

procedure TfrmHomeLoggedIn.imgDamListHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgDamListHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmHomeLoggedIn.imgDamListMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgDamListHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmHomeLoggedIn.imgMapViewHoverClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  frmMapView.Show;
  Self.Hide;
  // GUI CODE END
end;

procedure TfrmHomeLoggedIn.imgMapViewHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgMapViewHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmHomeLoggedIn.imgMapViewMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgMapViewHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmHomeLoggedIn.imgSignOutMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgSignOut_hover.Visible := True;
  // GUI CODE END
end;

procedure TfrmHomeLoggedIn.imgSignOut_hoverClick(Sender: TObject);
begin
  frmHomePage.Show;
  frmHomeLoggedIn.Hide;

  frmGraphView.ActiveUser.Free;
end;

procedure TfrmHomeLoggedIn.imgSignOut_hoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgSignOut_hover.Visible := False;
  // GUI CODE END
end;

procedure TfrmHomeLoggedIn.imgUserStatsHoverClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  frmGraphView.OrigionForm := 3;
  frmGraphView.Show;
  frmHomeLoggedIn.Hide;
  // GUI CODE END
end;

procedure TfrmHomeLoggedIn.imgUserStatsHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgUserStatsHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmHomeLoggedIn.imgUserStatsMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgUserStatsHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmHomeLoggedIn.Panel1Resize(Sender: TObject);
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

procedure TfrmHomeLoggedIn.ResizeRePos(MainImage, MovingImage: TImage);
begin
  // GUI CODE BEGIN
  MovingImage.Width := MainImage.Width;
  MovingImage.Height := MainImage.Height;

  MovingImage.Top := MainImage.Top;
  MovingImage.Left := MainImage.Left;
  // GUI CODE END
end;

end.
