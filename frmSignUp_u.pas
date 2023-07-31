unit frmSignUp_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UITypes, BCrypt,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, clsUSER_u, clsValidation_u, Data.DB, Vcl.Grids,
  Vcl.DBGrids, dmWaterBoard_u, clsADDRESS_u, clsTarget_u;

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
    procedure edtConfirmPasswordClick(Sender: TObject);
    procedure edtPasswordClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    objNewUser: TUser;
    objNewAddress: TAddress;
    objValidate: TValidate;
    objNewTarget: TTarget;
  public
    { Public declarations }
    sValidateStr: String;
  end;

var
  frmSignUp: TfrmSignUp;

implementation

{$R *.dfm}

uses frmHomeLoggedIn_u, frmLogin_u, frmHomePage_u, frmGraphView_u;

procedure TfrmSignUp.edtConfirmPasswordClick(Sender: TObject);
begin
  if edtConfirmPassword.PasswordChar = #0 then
    edtConfirmPassword.PasswordChar := '*'
  else
    edtConfirmPassword.PasswordChar := #0;

  edtConfirmPassword.AutoSelect := False;
end;

procedure TfrmSignUp.edtPasswordClick(Sender: TObject);

begin
  if edtPassword.PasswordChar = #0 then
    edtPassword.PasswordChar := '*'
  else
    edtPassword.PasswordChar := #0;

  edtPassword.AutoSelect := False;
end;

procedure TfrmSignUp.edtUsernameExit(Sender: TObject);
var
  bUnique: Boolean;
begin
  // Create a new validation object
  objValidate := TValidate.Create;

  // Check if the entered username is unique in the user table
  // using the CheckUnique method of the validation object
  bUnique := objValidate.CheckUnique(edtUsername.Text, 'USER', 'username');

  // If the username is not unique
  if not bUnique then
  begin
    // Display a message dialog to inform the user that the username already exists
    MessageDlg('Username already exists', mtError, [mbOK], 0);

    // Clear the username input field
    edtUsername.Clear;

    // Set the focus to the username input field so the user can enter a new username
    edtUsername.SetFocus;
  end;
end;


procedure TfrmSignUp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Clear all inputs
  edtFirstName.Clear;
  edtSurname.Clear;
  edtUsername.Clear;
  edtPassword.Clear;
  edtConfirmPassword.Clear;
  edtEmail.Clear;
  edtStreetNo.Clear;
  edtStreetName.Clear;
  edtSuburb.Clear;
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
  rTargetValue: Real;
  sTargetValue: String;
  bComplete: Boolean;
begin
  // Initialize validation string
  sValidateStr := '';

  // Get user input from the form
  sFirstName := edtFirstName.Text;
  sSurname := edtSurname.Text;
  sUsername := edtUsername.Text;
  sPassword := edtPassword.Text;
  sConfirmPassword := edtConfirmPassword.Text;
  sEmail := edtEmail.Text;

  sUnitNumber := edtStreetNo.Text;
  sStreetName := edtStreetName.Text;
  sSuburb := edtSuburb.Text;

  // Start the validation process
  with objValidate do
  begin
    // Check if password confirmation field is not empty
    if CheckNull(sConfirmPassword) then
    begin
      // Display error message
      MessageDlg('Please confirm your password', mtError, [mbOK], 0);
      Exit
    end;

    // Check if passwords match
    if not CheckSame(sPassword, sConfirmPassword) then
    begin
      // Display error message
      MessageDlg('Passwords do not match', mtError, [mbOK], 0);
      // Clear the password fields
      edtPassword.Clear;
      edtConfirmPassword.Clear;
      // Set focus to password field
      edtPassword.SetFocus;

      Exit
    end;
  end;

  // Create a new address with user input
  objNewAddress := TAddress.Create(sUnitNumber, sStreetName, sSuburb);
  // Validate address fields
  arrErrorFields := objNewAddress.Validate(sValidateStr);

  // Hash the password using BCrypt
  sPassword := TBCrypt.HashPassword(sPassword);
  // Create a new user with user input
  objNewUser := TUser.Create(sFirstName, sSurname, sUsername,
    sPassword, sEmail);

  // Validate user fields
  arrErrorFields := objNewUser.Validate(sValidateStr);

  // Check if validation string is empty
  if sValidateStr = '' then
  begin
    // Insert user record into the database
    objNewUser.InsertUserRecord(objNewAddress);

    // GUI CODE START
    // Log in and display home page
    frmHomeLoggedIn.Show;
    // Hide sign up and home pages
    frmSignUp.Hide;
    frmHomePage.Hide;

    // Clear input fields
    edtFirstName.Clear;
    edtSurname.Clear;
    edtUsername.Clear;
    edtPassword.Clear;
    edtConfirmPassword.Clear;
    edtEmail.Clear;
    edtStreetNo.Clear;
    edtStreetName.Clear;
    edtSuburb.Clear;

    // Set the login status to true
    frmHomeLoggedIn.bLoggedIn := True;

    // Set the active user for the graph view form
    frmGraphView.ActiveUser := objNewUser;
    // GUI CODE END

    // Loop until a valid target value is entered
    bComplete := False;
    Repeat
      // Ask the user to enter a target value
      sTargetValue := InputBox('Enter new target',
        'Please enter a monthly water usage target to get started:', '');

      // Check if the entered target value is a real number
      if objValidate.CheckReal(sTargetValue) then
      begin
        // Create a new target with the current date, target value, and user id
        objNewTarget := TTarget.Create(now, rTargetValue, objNewUser.GetUserID);
        // Mark the process as complete
        bComplete := True;
      end
      else
        // Show error message if the entered target value is not a real number
        Showmessage
          ('Please enter a valid monthly water usage target in kilo litres. Eg. 6,33 kl');
    until bComplete = True;
  end
  else
  begin
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
