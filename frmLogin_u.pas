unit frmLogin_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, frmHomeLoggedIn_u, clsUser_u;

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
    objExistingUser: TUser;
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
  // GUI CODE START
  imgLoginHover.Width := imgLogin.Width;
  imgLoginHover.Height := imgLogin.Height;

  imgLoginHover.Top := imgLogin.Top;
  imgLoginHover.Left := imgLogin.Left;
  // GUI CODE END
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  // GUI CODE START
  imgLoginHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmLogin.imgLoginHoverClick(Sender: TObject);
var
  sUsername, sPassword: String;
  bValidUser: Boolean;
begin
  sUsername := edtUsername.Text;
  sPassword := edtPassword.Text;

  objExistingUser := TUser.Create(sUsername, sPassword);
  bValidUser := objExistingUser.CheckLogin;

  if bValidUser then
  begin // success

    // GUI CODE START
    // Logged In
    frmHomeLoggedIn.Show;
    frmLogin.Hide;
    frmHomePage.Hide;

    frmHomeLoggedIn.bLoggedIn := True;
    // GUI CODE END
  end
  else // error
  begin
    Showmessage('Username or password incorrect');
    edtPassword.Clear;
    edtPassword.SetFocus;
  end;

end;

procedure TfrmLogin.imgLoginHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE START
  imgLoginHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmLogin.imgLoginMouseEnter(Sender: TObject);
begin
  // GUI CODE START
  imgLoginHover.Visible := True;
  // GUI CODE END
end;

end.
