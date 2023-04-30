program waterBOARD_p;

uses
  Vcl.Forms,
  frmHomePage_u in 'frmHomePage_u.pas' {frmHomePage},
  frmDamList_u in 'frmDamList_u.pas' {frmDamList},
  frmGraphView_u in 'frmGraphView_u.pas' {frmGraphView},
  frmMapView_u in 'frmMapView_u.pas' {frmMapView},
  frmLogin_u in 'frmLogin_u.pas' {frmLogin},
  frmSignUp_u in 'frmSignUp_u.pas' {frmSignUp},
  frmHomeLoggedIn_u in 'frmHomeLoggedIn_u.pas' {frmHomeLoggedIn};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHomePage, frmHomePage);
  Application.CreateForm(TfrmDamList, frmDamList);
  Application.CreateForm(TfrmGraphView, frmGraphView);
  Application.CreateForm(TfrmMapView, frmMapView);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmSignUp, frmSignUp);
  Application.CreateForm(TfrmHomeLoggedIn, frmHomeLoggedIn);
  Application.Run;
end.
