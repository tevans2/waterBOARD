unit frmDamList_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Math, frmGraphView_u;

type
  TfrmDamList = class(TForm)
    imgBergRiver: TImage;
    imgWemmershoek: TImage;
    imgSteenbrasUp: TImage;
    imgSteenbrasLow: TImage;
    imgVoelvlei: TImage;
    imgTheewaterskloof: TImage;
    pnlHomePage: TPanel;
    pnlContainer: TPanel;
    rectContainer: TShape;
    pnlCards: TPanel;
    Panel2: TPanel;
    Shape1: TShape;
    Panel3: TPanel;
    imgLogoIcon: TImage;
    imgHome: TImage;
    imgHomeHover: TImage;
    procedure imgBergRiverMouseEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgBergRiverMouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgSteenbrasLowMouseEnter(Sender: TObject);
    procedure imgSteenbrasLowMouseLeave(Sender: TObject);
    procedure imgSteenbrasUpMouseEnter(Sender: TObject);
    procedure imgSteenbrasUpMouseLeave(Sender: TObject);
    procedure imgWemmershoekMouseEnter(Sender: TObject);
    procedure imgWemmershoekMouseLeave(Sender: TObject);
    procedure imgVoelvleiMouseEnter(Sender: TObject);
    procedure imgVoelvleiMouseLeave(Sender: TObject);
    procedure imgTheewaterskloofMouseEnter(Sender: TObject);
    procedure imgTheewaterskloofMouseLeave(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pnlContainerResize(Sender: TObject);
    procedure imgBergRiverClick(Sender: TObject);
    procedure imgHomeMouseEnter(Sender: TObject);
    procedure imgHomeHoverMouseLeave(Sender: TObject);
    procedure imgHomeHoverClick(Sender: TObject);
    procedure imgSteenbrasUpClick(Sender: TObject);
    procedure imgWemmershoekClick(Sender: TObject);
    procedure imgTheewaterskloofClick(Sender: TObject);
    procedure imgSteenbrasLowClick(Sender: TObject);
    procedure imgVoelvleiClick(Sender: TObject);
  private
    { Private declarations }
    MainRatio: Real;
    DamListOrigionalHeight: Integer;
    DamListOrigionalWidth: Integer;
    DamListExpandedHeight: Integer;
    procedure ExpandImage(Image: TImage);
    procedure RetractImage(Image: TImage);
    procedure ResetDimensions();
  public
    { Public declarations }
  end;

const
  ExpandFactor = 0.30;

var
  frmDamList: TfrmDamList;

implementation

{$R *.dfm}

uses
  frmHomePage_u, frmHomeLoggedIn_u;

procedure TfrmDamList.ExpandImage(Image: TImage);
begin
  // GUI CODE BEGIN
  if (Image.Height < DamListExpandedHeight) then
    repeat
    begin

      Image.Proportional := False;
      Image.Width := Image.Width + Round(DamListExpandedHeight / 32);

      Image.Height := trunc(Image.Width * MainRatio) div 100;
      Image.Proportional := True;
      Image.Refresh;

    end;
    until (Image.Height > DamListExpandedHeight);
  // GUI CODE END
end;

procedure TfrmDamList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // GUI CODE BEGIN
  frmHomePage.Close;
  // GUI CODE END
end;

procedure TfrmDamList.FormResize(Sender: TObject);
var
  Ratio: Real;
begin
  // GUI CODE BEGIN
  ResetDimensions;
  Ratio := min(ClientWidth / pnlHomePage.Width,
    ClientHeight / pnlHomePage.Height);
  pnlHomePage.ScaleBy(trunc(Ratio * 100), 100);

  frmHomePage.MasterWindowState := Self.WindowState;

  imgHomeHover.Left := imgHome.Left;
  imgHomeHover.Top := imgHome.Top;
  // GUI CODE END
end;

procedure TfrmDamList.FormShow(Sender: TObject);
begin
  // GUI CODE BEGIN
  ResetDimensions;

  imgHomeHover.Visible := False;
  WindowState := frmHomePage.MasterWindowState;

  // GUI CODE END
end;

procedure TfrmDamList.imgSteenbrasLowClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  frmGraphView.DamID := 2;
  frmGraphView.OrigionForm := 1;
  frmGraphView.Show;
  Self.Hide;

  // GUI CODE END
end;

procedure TfrmDamList.imgSteenbrasLowMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  ExpandImage(imgSteenbrasLow);
  // GUI CODE END
end;

procedure TfrmDamList.imgSteenbrasLowMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  RetractImage(imgSteenbrasLow);
  // GUI CODE END
end;

procedure TfrmDamList.imgSteenbrasUpClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  frmGraphView.DamID := 3;
  frmGraphView.OrigionForm := 1;
  frmGraphView.Show;
  Self.Hide;
  // GUI CODE END
end;

procedure TfrmDamList.imgSteenbrasUpMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  ExpandImage(imgSteenbrasUp);
  // GUI CODE END
end;

procedure TfrmDamList.imgSteenbrasUpMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  RetractImage(imgSteenbrasUp);
  // GUI CODE END
end;

procedure TfrmDamList.imgTheewaterskloofClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  frmGraphView.DamID := 4;
  frmGraphView.OrigionForm := 1;
  frmGraphView.Show;
  Self.Hide;
  // GUI CODE END
end;

procedure TfrmDamList.imgTheewaterskloofMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  ExpandImage(imgTheewaterskloof);
  // GUI CODE END
end;

procedure TfrmDamList.imgTheewaterskloofMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  RetractImage(imgTheewaterskloof);
  // GUI CODE END
end;

procedure TfrmDamList.imgVoelvleiClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  frmGraphView.DamID := 5;
  frmGraphView.OrigionForm := 1;
  frmGraphView.Show;
  Self.Hide;
  // GUI CODE END
end;

procedure TfrmDamList.imgVoelvleiMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  ExpandImage(imgVoelvlei);
  // GUI CODE END
end;

procedure TfrmDamList.imgVoelvleiMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  RetractImage(imgVoelvlei);
  // GUI CODE END
end;

procedure TfrmDamList.imgWemmershoekClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  frmGraphView.DamID := 6;
  frmGraphView.OrigionForm := 1;
  frmGraphView.Show;
  Self.Hide;
  // GUI CODE END
end;

procedure TfrmDamList.imgWemmershoekMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  ExpandImage(imgWemmershoek);
  // GUI CODE END
end;

procedure TfrmDamList.imgWemmershoekMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  RetractImage(imgWemmershoek);
  // GUI CODE END
end;

procedure TfrmDamList.pnlContainerResize(Sender: TObject);
var
  Ratio: Real;
begin

  // GUI CODE START
  Ratio := min(pnlContainer.Width / pnlCards.Width, pnlContainer.Height /
    pnlCards.Height);
  pnlCards.ScaleBy(trunc(Ratio * 100), 100);

  ResetDimensions;
  with pnlCards do
  begin
    Left := (pnlContainer.Width - Width) div 2;
    Top := (pnlContainer.Height - Height) div 2;
  end;
  // GUI CODE END
end;

procedure TfrmDamList.imgBergRiverClick(Sender: TObject);
begin
  // GUI CODE START
  frmGraphView.DamID := 1;
  frmGraphView.OrigionForm := 1;
  frmGraphView.Show;
  Self.Hide;

  // GUI CODE END
end;

procedure TfrmDamList.imgBergRiverMouseEnter(Sender: TObject);
begin
  // GUI CODE START
  ExpandImage(imgBergRiver);
  // GUI CODE END
end;

procedure TfrmDamList.imgBergRiverMouseLeave(Sender: TObject);
begin
  // GUI CODE START     // GUI CODE END
  RetractImage(imgBergRiver);
end;

procedure TfrmDamList.imgHomeHoverClick(Sender: TObject);
begin
  // GUI CODE START
  case frmHomeLoggedIn.bLoggedIn of
    True:
      frmHomeLoggedIn.Show;
    False:
      frmHomePage.Show;
  end;

  Self.Hide;
  // GUI CODE END
end;

procedure TfrmDamList.imgHomeHoverMouseLeave(Sender: TObject);
begin
  imgHomeHover.Visible := False;
end;

procedure TfrmDamList.imgHomeMouseEnter(Sender: TObject);
begin
  // GUI CODE START
  imgHomeHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmDamList.ResetDimensions;
begin
  // GUI CODE START
  DamListOrigionalHeight := imgBergRiver.Height;
  DamListOrigionalWidth := imgBergRiver.Width;

  MainRatio := (DamListOrigionalHeight / DamListOrigionalWidth) * 100;

  DamListExpandedHeight := Round(DamListOrigionalHeight + DamListOrigionalHeight
    * ExpandFactor);
  // GUI CODE END
end;

procedure TfrmDamList.RetractImage(Image: TImage);
begin
  // GUI CODE START
  if (Image.Height > DamListOrigionalHeight) then
    repeat
    begin
      Image.Proportional := False;
      Image.Width := Image.Width - Round(DamListExpandedHeight / 32);

      Image.Height := trunc(Image.Width * MainRatio) div 100;

      Image.Proportional := True;
      Image.Refresh;
    end;
    until (Image.Height <= DamListOrigionalHeight);
end;

// GUI CODE END
end.
