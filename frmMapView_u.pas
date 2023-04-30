unit frmMapView_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Math,
  Vcl.Imaging.jpeg, Vcl.StdCtrls;

type
  TfrmMapView = class(TForm)
    pnlHomePage: TPanel;
    Panel1: TPanel;
    Shape2: TShape;
    imgMap: TImage;
    lblDamName: TLabel;
    imgVoelVlei: TImage;
    imgWemmershoek: TImage;
    imgSteenbrasUp: TImage;
    imgSteenbrasLow: TImage;
    imgBergRiver: TImage;
    imgTheewaterskloof: TImage;
    Panel2: TPanel;
    Shape1: TShape;
    Panel3: TPanel;
    imgLogoIcon: TImage;
    imgHome: TImage;
    imgHomeHover: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure imgVoelVleiMouseEnter(Sender: TObject);
    procedure imgVoelVleiMouseLeave(Sender: TObject);
    procedure PositionDamTitle(dam_name: String; DamPin: TImage);
    procedure imgWemmershoekMouseEnter(Sender: TObject);
    procedure imgWemmershoekMouseLeave(Sender: TObject);
    procedure imgBergRiverMouseEnter(Sender: TObject);
    procedure imgBergRiverMouseLeave(Sender: TObject);
    procedure imgTheewaterskloofMouseEnter(Sender: TObject);
    procedure imgTheewaterskloofMouseLeave(Sender: TObject);
    procedure imgSteenbrasUpMouseEnter(Sender: TObject);
    procedure imgSteenbrasUpMouseLeave(Sender: TObject);
    procedure imgSteenbrasLowMouseEnter(Sender: TObject);
    procedure imgSteenbrasLowMouseLeave(Sender: TObject);
    procedure imgHomeMouseEnter(Sender: TObject);
    procedure imgHomeHoverMouseLeave(Sender: TObject);
    procedure imgHomeHoverClick(Sender: TObject);
    procedure imgVoelVleiClick(Sender: TObject);
    procedure imgWemmershoekClick(Sender: TObject);
    procedure imgBergRiverClick(Sender: TObject);
    procedure imgTheewaterskloofClick(Sender: TObject);
    procedure imgSteenbrasUpClick(Sender: TObject);
    procedure imgSteenbrasLowClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMapView: TfrmMapView;

implementation

{$R *.dfm}

uses frmHomePage_u, frmGraphView_u, frmHomeLoggedIn_u;

procedure TfrmMapView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmHomePage.close;
end;

procedure TfrmMapView.FormResize(Sender: TObject);
var
  Ratio: Real;
begin
  Ratio := min(ClientWidth / pnlHomePage.Width,
    ClientHeight / pnlHomePage.Height);
  pnlHomePage.ScaleBy(trunc(Ratio * 100), 100);

  frmHomePage.MasterWindowState := Self.WindowState;

  imgHomeHover.Left := imgHome.Left;
  imgHomeHover.Top := imgHome.Top;
end;

procedure TfrmMapView.FormShow(Sender: TObject);
begin
  WindowState := frmHomePage.MasterWindowState;
  imgHomeHover.Visible := False;
end;

procedure TfrmMapView.imgBergRiverClick(Sender: TObject);
begin
  frmGraphView.Show;
  Self.Hide;
  frmGraphView.OrigionForm := 2;
end;

procedure TfrmMapView.imgBergRiverMouseEnter(Sender: TObject);
begin
  PositionDamTitle('Berg River', imgBergRiver);
end;

procedure TfrmMapView.imgBergRiverMouseLeave(Sender: TObject);
begin
  lblDamName.Caption := '';
  lblDamName.Transparent := True;
end;

procedure TfrmMapView.imgHomeHoverClick(Sender: TObject);
begin
  case frmHomeLoggedIn.bLoggedIn of
    True:
      frmHomeLoggedIn.Show;
    False:
      frmHomePage.Show;
  end;

  Self.Hide;
end;

procedure TfrmMapView.imgHomeHoverMouseLeave(Sender: TObject);
begin
  imgHomeHover.Visible := False;
end;

procedure TfrmMapView.imgHomeMouseEnter(Sender: TObject);
begin
  imgHomeHover.Visible := True;
end;

procedure TfrmMapView.imgSteenbrasLowClick(Sender: TObject);
begin
  frmGraphView.Show;
  Self.Hide;
  frmGraphView.OrigionForm := 2;
end;

procedure TfrmMapView.imgSteenbrasLowMouseEnter(Sender: TObject);
begin
  PositionDamTitle('Steenbras Lower', imgSteenbrasLow);
end;

procedure TfrmMapView.imgSteenbrasLowMouseLeave(Sender: TObject);
begin
  lblDamName.Caption := '';
  lblDamName.Transparent := True;
end;

procedure TfrmMapView.imgSteenbrasUpClick(Sender: TObject);
begin
  frmGraphView.Show;
  Self.Hide;
  frmGraphView.OrigionForm := 2;
end;

procedure TfrmMapView.imgSteenbrasUpMouseEnter(Sender: TObject);
begin
  PositionDamTitle('Steenbras Upper', imgSteenbrasUp);
end;

procedure TfrmMapView.imgSteenbrasUpMouseLeave(Sender: TObject);
begin
  lblDamName.Caption := '';
  lblDamName.Transparent := True;
end;

procedure TfrmMapView.imgTheewaterskloofClick(Sender: TObject);
begin
  frmGraphView.Show;
  Self.Hide;
  frmGraphView.OrigionForm := 2;
end;

procedure TfrmMapView.imgTheewaterskloofMouseEnter(Sender: TObject);
begin
  PositionDamTitle('Theewaterskloof', imgTheewaterskloof);
end;

procedure TfrmMapView.imgTheewaterskloofMouseLeave(Sender: TObject);
begin
  lblDamName.Caption := '';
  lblDamName.Transparent := True;
end;

procedure TfrmMapView.imgVoelVleiClick(Sender: TObject);
begin
  frmGraphView.Show;
  Self.Hide;
  frmGraphView.OrigionForm := 2;
end;

procedure TfrmMapView.imgVoelVleiMouseEnter(Sender: TObject);
begin
  PositionDamTitle('Voelvlei', imgVoelVlei);
end;

procedure TfrmMapView.imgVoelVleiMouseLeave(Sender: TObject);
begin
  lblDamName.Caption := '';
  lblDamName.Transparent := True;
end;

procedure TfrmMapView.imgWemmershoekClick(Sender: TObject);
begin
  frmGraphView.Show;
  Self.Hide;
  frmGraphView.OrigionForm := 2;
end;

procedure TfrmMapView.imgWemmershoekMouseEnter(Sender: TObject);
begin
  PositionDamTitle('Wemmershoek', imgWemmershoek);
end;

procedure TfrmMapView.imgWemmershoekMouseLeave(Sender: TObject);
begin
  lblDamName.Caption := '';
  lblDamName.Transparent := True;
end;

procedure TfrmMapView.Panel1Resize(Sender: TObject);
var
  Ratio: Real;
begin
  Ratio := min(ClientWidth / pnlHomePage.Width,
    ClientHeight / pnlHomePage.Height);
  Panel1.ScaleBy(trunc(Ratio * 100), 100);
end;

procedure TfrmMapView.PositionDamTitle(dam_name: String; DamPin: TImage);
begin
  lblDamName.Caption := dam_name;
  lblDamName.Top := DamPin.Top;
  lblDamName.Left := DamPin.Left + DamPin.Width;
  lblDamName.Transparent := False;
end;

end.
