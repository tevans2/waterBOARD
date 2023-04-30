unit frmLogin_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, frmHomeLoggedIn_u;

type
  TfrmLogin = class(TForm)
    pnlHeader: TPanel;
    imgLogo: TImage;
    edtUsername: TEdit;
    edtPassword: TEdit;
    pnlBody: TPanel;
    lblUsername: TLabel;
    lblPassword: TLabel;
    imgLogin: TImage;
    imgLoginHover: TImage;
    Shape1: TShape;
    procedure FormResize(Sender: TObject);
    procedure imgLoginHoverMouseLeave(Sender: TObject);
    procedure imgLoginMouseEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgLoginHoverClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses frmHomePage_u;

procedure TfrmLogin.FormResize(Sender: TObject);
begin
  imgLoginHover.Width := imgLogin.Width;
  imgLoginHover.Height := imgLogin.Height;

  imgLoginHover.Top := imgLogin.Top;
  imgLoginHover.Left := imgLogin.Left;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  imgLoginHover.Visible := False;

end;

procedure TfrmLogin.imgLoginHoverClick(Sender: TObject);
begin
  // Logged In
   frmHomeLoggedIn.Show;
   frmLogin.Hide;
   frmHomePage.hide;

   frmHomeLoggedIn.bLoggedIn := True;
end;

procedure TfrmLogin.imgLoginHoverMouseLeave(Sender: TObject);
begin
  imgLoginHover.Visible := False;
end;

procedure TfrmLogin.imgLoginMouseEnter(Sender: TObject);
begin
  imgLoginHover.Visible := True;
end;

end.
