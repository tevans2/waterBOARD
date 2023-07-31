unit frmLoadingPage_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.GIFImg, Vcl.ExtCtrls,
  clsDamReading_u,
  Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

type
  TfrmLoadingPage = class(TForm)
    imgLoading: TImage;
    Panel1: TPanel;
    imgTick: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    objDamReading: TDamReading;
  public
    { Public declarations }
  end;

var
  frmLoadingPage: TfrmLoadingPage;

implementation

{$R *.dfm}

procedure TfrmLoadingPage.FormShow(Sender: TObject);
begin
  // GUI CODE BEGIN
  (imgLoading.Picture.Graphic as TGIFImage).Animate := True;
  (imgLoading.Picture.Graphic as TGIFImage).AnimationSpeed := 2000;

  frmLoadingPage.DoubleBuffered := True;

  imgTick.Visible := False;
  // GUI CODE END
end;

end.
