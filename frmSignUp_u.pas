unit frmSignUp_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, clsUSER_u, clsValidation_u, Data.DB, Vcl.Grids,
  Vcl.DBGrids, dmWaterBoard_u, clsADDRESS_u;

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
    procedure edtUsernameExit(Sender: TObject);
  private
    { Private declarations }
    objNewUser: TUser;
    objNewAddress: TAddress;
    objValidate: TValidate;
  public
    { Public declarations }
    sValidateStr: String;
  end;

var
  frmSignUp: TfrmSignUp;

implementation

{$R *.dfm}

procedure TfrmSignUp.edtUsernameExit(Sender: TObject);
var
  bUnique: Boolean;
begin
  objValidate := TValidate.Create;
  bUnique := objValidate.CheckUnique(edtUsername.Text, 'USER', 'username');

  if not bUnique then
  begin
    MessageDlg('Username already exists', mtError, [mbOK], 0);
    edtUsername.Clear;
    edtUsername.SetFocus;
  end;
end;

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
  sFirstName, sSurname, sUsername, sPassword, sConfirmPassword, sEmail: String;
  sStreetName, sSuburb, sUnitNumber: String;
  iPos, iNum: Integer;
  arrErrorFields: TArray<Integer>;
  i: Integer;
begin
  sValidateStr := '';

  sFirstName := edtFirstName.Text;
  sSurname := edtSurname.Text;
  sUsername := edtUsername.Text;
  sPassword := edtPassword.Text;
  sConfirmPassword := edtConfirmPassword.Text;
  sEmail := edtEmail.Text;

  sUnitNumber := edtStreetNo.Text;
  sStreetName := edtStreetName.Text;
  sSuburb := edtSuburb.Text;

  // VALIDATION
  with objValidate do
  begin
    if CheckNull(sConfirmPassword) then
    begin
      MessageDlg('Please confirm your password', mtError, [mbOK], 0);
      Exit
    end;

    // Check passwords match
    if not CheckSame(sPassword, sConfirmPassword) then
    begin
      MessageDlg('Passwords do not match', mtError, [mbOK], 0);
      edtPassword.Clear;
      edtConfirmPassword.Clear;
      edtPassword.SetFocus;

      Exit
    end;
  end;

  objNewAddress := TAddress.Create(sUnitNumber, sStreetName, sSuburb);
  arrErrorFields := objNewAddress.Validate(sValidateStr);

  objNewUser := TUser.Create(sFirstName, sSurname, sUsername,
    sPassword, sEmail);
  arrErrorFields := objNewUser.Validate(sValidateStr);

  if sValidateStr = '' then
    objNewUser.InsertUserRecord(objNewAddress)
  else
    for i := 0 to Length(arrErrorFields) - 1 do
    begin
      // Validation Result Key:
      // 1 = First Name
      // 2 = Surname
      // 3 = Email
      // 4 = Username
      // 5 = Password
      // 6 = Unit Number
      // 7 = Street Name
      // 8 = Suburb

      case arrErrorFields[i] of
        1:
          edtFirstName.Clear;
        2:
          edtSurname.Clear;
        3:
          edtEmail.Clear;
        4:
          edtUsername.Clear;
        5:
          edtPassword.Clear;
        6:
          edtStreetNo.Clear;
        7:
          edtStreetName.Clear;
        8:
          edtSuburb.Clear;
      end;
    end;
  sValidateStr := trim(sValidateStr);
  MessageDlg(sValidateStr, mtError, [mbOK], 0);
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
