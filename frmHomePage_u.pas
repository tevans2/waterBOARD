unit frmHomePage_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Math,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, frmDamList_u, frmMapView_u, frmLogin_u,
  frmSignUp_u, frmHomeLoggedIn_u;

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
  Ratio := min(ClientWidth / pnlHomePage.Width,
    ClientHeight / pnlHomePage.Height);
  pnlHomePage.ScaleBy(Trunc(Ratio * 100), 100);

  frmHomePage.MasterWindowState := Self.WindowState;
end;

procedure TfrmHomePage.FormShow(Sender: TObject);
begin
  WindowState := frmHomePage.MasterWindowState;

  frmHomeLoggedIn.bLoggedIn := False;
end;

procedure TfrmHomePage.imgDamListHoverClick(Sender: TObject);
begin
  frmDamList.Show;
  Self.Hide;
end;

procedure TfrmHomePage.imgDamListHoverMouseLeave(Sender: TObject);
begin
  imgDamList.Visible := True;
  imgDamListHover.Visible := False;
end;

procedure TfrmHomePage.imgLoginHoverClick(Sender: TObject);
begin
  frmLogin.Show;
end;

procedure TfrmHomePage.imgLoginHoverMouseLeave(Sender: TObject);
begin
  imgLogin.Visible := True;
  imgLoginHover.Visible := False;
end;

procedure TfrmHomePage.imgLoginMouseEnter(Sender: TObject);
begin
  imgLogin.Visible := False;
  imgLoginHover.Visible := True;
end;

procedure TfrmHomePage.imgMapViewHoverClick(Sender: TObject);
begin
  frmMapView.Show;
  Self.Hide;
end;

procedure TfrmHomePage.imgMapViewHoverMouseLeave(Sender: TObject);
begin
  imgMapView.Visible := True;
  imgMapViewHover.Visible := False;
end;

procedure TfrmHomePage.imgMapViewMouseEnter(Sender: TObject);
begin
  imgMapView.Visible := False;
  imgMapViewHover.Visible := True;

end;

procedure TfrmHomePage.imgSignUpHoverClick(Sender: TObject);
begin
  frmSignUp.Show;

end;

procedure TfrmHomePage.imgSignUpHoverMouseLeave(Sender: TObject);
begin
  imgSignUp.Visible := True;
  imgSignUpHover.Visible := False;
end;

procedure TfrmHomePage.imgSignUpMouseEnter(Sender: TObject);
begin
  imgSignUp.Visible := False;
  imgSignUpHover.Visible := True;
end;

procedure TfrmHomePage.imgDamListMouseEnter(Sender: TObject);
begin
  imgDamList.Visible := False;
  imgDamListHover.Visible := True;
end;

procedure TfrmHomePage.Panel1Resize(Sender: TObject);
var
  Ratio: Real;
begin
  Ratio := min(Panel1.Width / Panel4.Width, Panel1.Height / Panel4.Height);
  Panel4.ScaleBy(Trunc(Ratio * 100), 100);

  with Panel4 do
  begin
    Left := (Panel1.Width - Width) div 2;
    Top := (Panel1.Height - Height) div 2;
  end;
end;

end.
