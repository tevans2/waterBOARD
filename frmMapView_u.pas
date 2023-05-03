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
  // GUI CODE START
  frmHomePage.close;
  // GUI CODE END
end;

procedure TfrmMapView.FormResize(Sender: TObject);
var
  Ratio: Real;
begin
  // GUI CODE START
  Ratio := min(ClientWidth / pnlHomePage.Width,
    ClientHeight / pnlHomePage.Height);
  pnlHomePage.ScaleBy(trunc(Ratio * 100), 100);

  frmHomePage.MasterWindowState := Self.WindowState;

  imgHomeHover.Left := imgHome.Left;
  imgHomeHover.Top := imgHome.Top;
  // GUI CODE END
end;

procedure TfrmMapView.FormShow(Sender: TObject);
begin
  // GUI CODE START
  WindowState := frmHomePage.MasterWindowState;
  imgHomeHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmMapView.imgBergRiverClick(Sender: TObject);
begin
  // GUI CODE START
  frmGraphView.Show;
  Self.Hide;
  frmGraphView.OrigionForm := 2;
  // GUI CODE END
end;

procedure TfrmMapView.imgBergRiverMouseEnter(Sender: TObject);
begin
  // GUI CODE START
  PositionDamTitle('Berg River', imgBergRiver);
  // GUI CODE END
end;

procedure TfrmMapView.imgBergRiverMouseLeave(Sender: TObject);
begin
  // GUI CODE START
  lblDamName.Caption := '';
  lblDamName.Transparent := True;
  // GUI CODE END
end;

procedure TfrmMapView.imgHomeHoverClick(Sender: TObject);
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

procedure TfrmMapView.imgHomeHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE START
  imgHomeHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmMapView.imgHomeMouseEnter(Sender: TObject);
begin
  // GUI CODE START
  imgHomeHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmMapView.imgSteenbrasLowClick(Sender: TObject);
begin
  // GUI CODE START
  frmGraphView.Show;
  Self.Hide;
  frmGraphView.OrigionForm := 2;
  // GUI CODE END
end;

procedure TfrmMapView.imgSteenbrasLowMouseEnter(Sender: TObject);
begin
  // GUI CODE START
  PositionDamTitle('Steenbras Lower', imgSteenbrasLow);
  // GUI CODE END
end;

procedure TfrmMapView.imgSteenbrasLowMouseLeave(Sender: TObject);
begin
  // GUI CODE START
  lblDamName.Caption := '';
  lblDamName.Transparent := True;
  // GUI CODE END
end;

procedure TfrmMapView.imgSteenbrasUpClick(Sender: TObject);
begin
  // GUI CODE START
  frmGraphView.Show;
  Self.Hide;
  frmGraphView.OrigionForm := 2;
  // GUI CODE END
end;

procedure TfrmMapView.imgSteenbrasUpMouseEnter(Sender: TObject);
begin
  // GUI CODE START
  PositionDamTitle('Steenbras Upper', imgSteenbrasUp);
  // GUI CODE END
end;

procedure TfrmMapView.imgSteenbrasUpMouseLeave(Sender: TObject);
begin
  // GUI CODE START
  lblDamName.Caption := '';
  lblDamName.Transparent := True;
  // GUI CODE END
end;

procedure TfrmMapView.imgTheewaterskloofClick(Sender: TObject);
begin
  // GUI CODE START
  frmGraphView.Show;
  Self.Hide;
  frmGraphView.OrigionForm := 2;
  // GUI CODE END
end;

procedure TfrmMapView.imgTheewaterskloofMouseEnter(Sender: TObject);
begin
  // GUI CODE START
  PositionDamTitle('Theewaterskloof', imgTheewaterskloof);
  // GUI CODE END
end;

procedure TfrmMapView.imgTheewaterskloofMouseLeave(Sender: TObject);
begin
  // GUI CODE START
  lblDamName.Caption := '';
  lblDamName.Transparent := True;
  // GUI CODE END
end;

procedure TfrmMapView.imgVoelVleiClick(Sender: TObject);
begin
  // GUI CODE START
  frmGraphView.Show;
  Self.Hide;
  frmGraphView.OrigionForm := 2;
  // GUI CODE END
end;

procedure TfrmMapView.imgVoelVleiMouseEnter(Sender: TObject);
begin
  // GUI CODE START
  PositionDamTitle('Voelvlei', imgVoelVlei);
  // GUI CODE END
end;

procedure TfrmMapView.imgVoelVleiMouseLeave(Sender: TObject);
begin
  // GUI CODE START
  lblDamName.Caption := '';
  lblDamName.Transparent := True;
  // GUI CODE END
end;

procedure TfrmMapView.imgWemmershoekClick(Sender: TObject);
begin
  // GUI CODE START
  frmGraphView.Show;
  Self.Hide;
  frmGraphView.OrigionForm := 2;
  // GUI CODE END
end;

procedure TfrmMapView.imgWemmershoekMouseEnter(Sender: TObject);
begin
  // GUI CODE START
  PositionDamTitle('Wemmershoek', imgWemmershoek);
  // GUI CODE END
end;

procedure TfrmMapView.imgWemmershoekMouseLeave(Sender: TObject);
begin
  // GUI CODE START
  lblDamName.Caption := '';
  lblDamName.Transparent := True;
  // GUI CODE END
end;

procedure TfrmMapView.Panel1Resize(Sender: TObject);
var
  Ratio: Real;
begin
  // GUI CODE START
  Ratio := min(ClientWidth / pnlHomePage.Width,
    ClientHeight / pnlHomePage.Height);
  Panel1.ScaleBy(trunc(Ratio * 100), 100);
  // GUI CODE END
end;

procedure TfrmMapView.PositionDamTitle(dam_name: String; DamPin: TImage);
begin
  // GUI CODE START
  lblDamName.Caption := dam_name;
  lblDamName.Top := DamPin.Top;
  lblDamName.Left := DamPin.Left + DamPin.Width;
  lblDamName.Transparent := False;
  // GUI CODE END
end;

end.
