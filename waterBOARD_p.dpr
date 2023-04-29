program waterBOARD_p;

uses
  Vcl.Forms,
  frmHomePage_u in 'frmHomePage_u.pas' {frmHomePage},
  frmDamList_u in 'frmDamList_u.pas' {frmDamList},
  frmDamGraphView_u in 'frmDamGraphView_u.pas' {frmDamGraph},
  frmMapView_u in 'frmMapView_u.pas' {frmMapView},
  frmLogin_u in 'frmLogin_u.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHomePage, frmHomePage);
  Application.CreateForm(TfrmDamList, frmDamList);
  Application.CreateForm(TfrmDamGraph, frmDamGraph);
  Application.CreateForm(TfrmMapView, frmMapView);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.