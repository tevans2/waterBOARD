unit frmLogin_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, frmHomeLoggedIn_u, clsUser_u, frmGraphView_u;

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
    procedure edtPasswordClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmLogin.edtPasswordClick(Sender: TObject);
begin
  if edtPassword.PasswordChar = #0 then
    edtPassword.PasswordChar := '*'
  else
    edtPassword.PasswordChar := #0;

  edtPassword.AutoSelect := False;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  edtUsername.Clear;
  edtPassword.Clear;
end;

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
  frmLogin.DoubleBuffered := True;
  // GUI CODE END
end;

procedure TfrmLogin.imgLoginHoverClick(Sender: TObject);
var
  sUsername, sPassword: String;
  bValidUser: Boolean;
begin
  // Extract entered username and password from the respective text fields
  sUsername := edtUsername.Text;
  sPassword := edtPassword.Text;

  // Create a new user object with the entered username and password
  objExistingUser := TUser.Create(sUsername, sPassword);

  // Check if the entered username and password are valid
  bValidUser := objExistingUser.CheckLogin;

  if bValidUser then
  begin // login success

    // GUI CODE START
    // Display the logged in home page and hide the login form
    frmHomeLoggedIn.Show;
    frmLogin.Hide;

    // Clear the username and password text fields
    edtUsername.Clear;
    edtPassword.Clear;

    // Hide the home page form
    frmHomePage.Hide;

    // Set the logged in status to true
    frmHomeLoggedIn.bLoggedIn := True;

    // Set the active user for the graph view form
    frmGraphView.ActiveUser := objExistingUser;
    // GUI CODE END
  end
  else // login error
  begin
    // Show an error message to the user
    Showmessage('Username or password incorrect');

    // Clear and focus the password field to allow the user to try again
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
