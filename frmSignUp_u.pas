unit frmSignUp_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

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
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    lblFirstName: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure FormShow(Sender: TObject);
    procedure imgSignUpMouseEnter(Sender: TObject);
    procedure imgSignUpHoverMouseLeave(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSignUp: TfrmSignUp;

implementation

{$R *.dfm}

procedure TfrmSignUp.FormResize(Sender: TObject);
begin
  imgSignUpHover.Width := imgSignUp.Width;
  imgSignUpHover.Height := imgSignUp.Height;

  imgSignUpHover.Top := imgSignUp.Top;
  imgSignUpHover.Left := imgSignUp.Left;

  //Reposition hover

end;

procedure TfrmSignUp.FormShow(Sender: TObject);
begin

  imgSignUpHover.Visible := False;
end;

procedure TfrmSignUp.imgSignUpHoverMouseLeave(Sender: TObject);
begin
  imgSignUpHover.Visible := False;
end;

procedure TfrmSignUp.imgSignUpMouseEnter(Sender: TObject);
begin
  imgSignUpHover.Visible := True;
end;

end.
