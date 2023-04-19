unit frmHomePage_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Math,
  Vcl.Imaging.pngimage, Vcl.StdCtrls;

type
  TfrmHomePage = class(TForm)
    pnlHomePage: TPanel;
    Shape1: TShape;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Image1: TImage;
    Panel4: TPanel;
    ingDamList: TImage;
    imgMapView: TImage;
    imgSignUp: TImage;
    imgLogin: TImage;
    Shape2: TShape;
    imgDamListHover: TImage;
    imgMapViewHover: TImage;
    imgSignUpHover: TImage;
    imgLoginHover: TImage;
    procedure FormResize(Sender: TObject);
    procedure Panel4Resize(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure imgLoginMouseEnter(Sender: TObject);
    procedure imgLoginHoverMouseLeave(Sender: TObject);
    procedure imgMapViewMouseEnter(Sender: TObject);
    procedure imgMapViewHoverMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
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

procedure TfrmHomePage.imgMapViewHoverMouseLeave(Sender: TObject);
begin
  imgMapView.Visible := True;
  imgMapView.Visible := False;
  // test test test
  frmHomePage.Hide;
  Sleep(1000);
  frmHomePage.Show;
                ASDADAD FDSFSDF
                FDSFS
                FDSFSDF
                SDFS
                FSDF
                SDFSD
end;

procedure TfrmHomePage.imgMapViewMouseEnter(Sender: TObject);
begin
  imgMapView.Visible := False;
  imgMapView.Visible := True;
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

procedure TfrmHomePage.Panel4Resize(Sender: TObject);
var
  Ratio: Real;
begin

end;

end.
