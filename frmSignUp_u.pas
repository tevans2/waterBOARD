unit frmSignUp_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, clsUSER_u;

type
  TfrmSignUp = class(TForm)
    pnlBody: TPanel;
    imgSignUp: TImage;
    imgSignUpHover: TImage;
    pnlHeader: TPanel;
    Shape1: TShape;
    imgLogo: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    edtFirstName: TEdit;
    edtStreetNo: TEdit;
    edtEmail: TEdit;
    edtSurname: TEdit;
    lblFirstName: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    edtConfirmPassword: TEdit;
    edtStreetName: TEdit;
    edtSuburb: TEdit;
    lblStreetNo: TLabel;
    lblStreetName: TLabel;
    lblSuburb: TLabel;
    procedure FormShow(Sender: TObject);
    procedure imgSignUpMouseEnter(Sender: TObject);
    procedure imgSignUpHoverMouseLeave(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure imgSignUpHoverClick(Sender: TObject);
  private
    { Private declarations }
    objNewUser: TUser;
  public
    { Public declarations }
  end;

var
  frmSignUp: TfrmSignUp;

implementation

{$R *.dfm}

procedure TfrmSignUp.FormResize(Sender: TObject);
begin
  // GUI CODE BEGIN

  // Reposition hover
  imgSignUpHover.Width := imgSignUp.Width;
  imgSignUpHover.Height := imgSignUp.Height;

  imgSignUpHover.Top := imgSignUp.Top;
  imgSignUpHover.Left := imgSignUp.Left;

  // Lining up address labels
  lblStreetNo.Left := edtStreetNo.Left;
  lblStreetNo.Top := edtStreetNo.Top - 20;

  lblStreetName.Left := edtStreetName.Left;
  lblStreetName.Top := edtStreetName.Top - 20;

  lblSuburb.Left := edtSuburb.Left;
  lblSuburb.Top := edtSuburb.Top - 20;
  // GUI CODE END
end;

procedure TfrmSignUp.FormShow(Sender: TObject);
begin

  imgSignUpHover.Visible := False;
end;

procedure TfrmSignUp.imgSignUpHoverClick(Sender: TObject);
var
  sFirstName, sSurname, sUsername, sPassword, sEmail: String;
  sStreetName, sSuburb, sUnitNumber: String;
begin
  sFirstName := edtFirstName.Text;
  sSurname := edtSurname.Text;
  sUsername := edtUsername.Text;
  sPassword := edtUsername.Text;
  sEmail := edtEmail.Text;

  // VALIDATE!!!

  objNewUser := TUser.Create(sFirstName, sSurname, sUsername, sPassword, sEmail,
    sStreetName, sSuburb, sUnitNumber);

  objNewUser.InsertUserRecord;
end;

procedure TfrmSignUp.imgSignUpHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE START
  imgSignUpHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmSignUp.imgSignUpMouseEnter(Sender: TObject);
begin
  // GUI CODE START
  imgSignUpHover.Visible := True;
  // GUI CODE END
end;

end.
