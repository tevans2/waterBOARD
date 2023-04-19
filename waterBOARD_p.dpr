program waterBOARD_p;

uses
  Vcl.Forms,
  frmHomePage_u in 'frmHomePage_u.pas' {frmHomePage};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHomePage, frmHomePage);
  Application.Run;
end.
