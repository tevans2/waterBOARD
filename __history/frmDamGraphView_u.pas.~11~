unit frmDamGraphView_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  VclTee.TeeGDIPlus, VclTee.TeEngine, VclTee.Series, VclTee.TeeProcs,
  VclTee.Chart;

type
  TfrmDamGraph = class(TForm)
    pnlHomePage: TPanel;
    Panel1: TPanel;
    Shape2: TShape;
    Panel2: TPanel;
    Shape1: TShape;
    Panel3: TPanel;
    imgLogoIcon: TImage;
    imgHome: TImage;
    imgBackArrow: TImage;
    Chart1: TChart;
    Series1: TLineSeries;
    imgBackArrowHover: TImage;
    imgHomeHover: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure imgBackArrowMouseEnter(Sender: TObject);
    procedure imgHomeMouseEnter(Sender: TObject);
    procedure imgBackArrowHoverMouseLeave(Sender: TObject);
    procedure imgHomeHoverMouseLeave(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure imgBackArrowHoverClick(Sender: TObject);
    procedure imgHomeHoverClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OrigionForm: integer;
  end;

var
  frmDamGraph: TfrmDamGraph;

implementation

{$R *.dfm}

uses frmHomePage_u, frmDamList_u, frmMapView_u;

procedure TfrmDamGraph.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmHomePage.close;
end;

procedure TfrmDamGraph.FormResize(Sender: TObject);
begin
  imgHomeHover.Left := imgHome.Left;
  imgHomeHover.Top := imgHome.Top;

  imgBackArrowHover.Left := imgBackArrow.Left;
  imgBackArrowHover.Top := imgBackArrow.Top;

  frmHomePage.MasterWindowState := Self.WindowState;
end;

procedure TfrmDamGraph.FormShow(Sender: TObject);
begin
  imgHomeHover.Visible := False;
  imgBackArrowHover.Visible := False;

  WindowState := frmHomePage.MasterWindowState;
end;

procedure TfrmDamGraph.imgBackArrowHoverClick(Sender: TObject);
begin
  case OrigionForm of
    1:
      frmDamList.Show;
    2:
      frmMapView.Show;
  end;

  Self.Hide;
end;

procedure TfrmDamGraph.imgBackArrowHoverMouseLeave(Sender: TObject);
begin
  imgBackArrowHover.Visible := False;
end;

procedure TfrmDamGraph.imgBackArrowMouseEnter(Sender: TObject);
begin
  imgBackArrowHover.Visible := True;
end;

procedure TfrmDamGraph.imgHomeHoverClick(Sender: TObject);
begin
  frmHomePage.Show;
  Self.Hide;
end;

procedure TfrmDamGraph.imgHomeHoverMouseLeave(Sender: TObject);
begin
  imgHomeHover.Visible := False;
end;

procedure TfrmDamGraph.imgHomeMouseEnter(Sender: TObject);
begin
  imgHomeHover.Visible := True;
end;

end.
