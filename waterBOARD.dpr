program waterBOARD;

uses
  Vcl.Forms,
  frmHomePage_u in 'frmHomePage_u.pas' {frmHomePage},
  frmDamList_u in 'frmDamList_u.pas' {frmDamList},
  frmGraphView_u in 'frmGraphView_u.pas' {frmGraphView},
  frmMapView_u in 'frmMapView_u.pas' {frmMapView},
  frmLogin_u in 'frmLogin_u.pas' {frmLogin},
  frmSignUp_u in 'frmSignUp_u.pas' {frmSignUp},
  frmHomeLoggedIn_u in 'frmHomeLoggedIn_u.pas' {frmHomeLoggedIn},
  dmWaterBoard_u in 'dmWaterBoard_u.pas' {dmWaterboard: TDataModule},
  clsUSER_u in 'User Defined Objects\clsUSER_u.pas',
  clsADDRESS_u in 'User Defined Objects\clsADDRESS_u.pas',
  clsValidation_u in 'User Defined Objects\clsValidation_u.pas',
  clsDamReading_u in 'User Defined Objects\clsDamReading_u.pas',
  clsDamGraph_u in 'User Defined Objects\clsDamGraph_u.pas',
  clsWaterMeterReading_u in 'User Defined Objects\clsWaterMeterReading_u.pas',
  clsTarget_u in 'User Defined Objects\clsTarget_u.pas',
  frmLoadingPage_u in 'frmLoadingPage_u.pas' {frmLoadingPage},
  clsUserGraph_u in 'User Defined Objects\clsUserGraph_u.pas';

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
  Application.CreateForm(TdmWaterboard, dmWaterboard);
  Application.CreateForm(TfrmLoadingPage, frmLoadingPage);
  Application.Run;
end.
