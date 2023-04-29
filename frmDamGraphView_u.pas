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
    imgBackArrow: TImage;
    Chart1: TChart;
    Series1: TLineSeries;
    imgBackArrowHover: TImage;
    imgHome_hover: TImage;
    imgHome: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure imgBackArrowMouseEnter(Sender: TObject);
    procedure imgHomeMouseEnter(Sender: TObject);
    procedure imgBackArrowHoverMouseLeave(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure imgBackArrowHoverClick(Sender: TObject);
    procedure imgHome_hoverMouseLeave(Sender: TObject);
    procedure imgHome_hoverClick(Sender: TObject);
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
  frmHomePage.Close;
end;

procedure TfrmDamGraph.FormResize(Sender: TObject);
begin
  imgHome_hover.Left := imgHome.Left;
  imgHome_hover.Top := imgHome.Top;

  imgBackArrowHover.Left := imgBackArrow.Left;
  imgBackArrowHover.Top := imgBackArrow.Top;

  frmHomePage.MasterWindowState := Self.WindowState;
end;

procedure TfrmDamGraph.FormShow(Sender: TObject);
begin
  imgHome_hover.Visible := False;
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

procedure TfrmDamGraph.imgHomeMouseEnter(Sender: TObject);
begin
  imgHome_hover.Visible := True;
end;

procedure TfrmDamGraph.imgHome_hoverClick(Sender: TObject);
begin
  frmHomePage.Show;
  Self.Hide;
end;

procedure TfrmDamGraph.imgHome_hoverMouseLeave(Sender: TObject);
begin
  imgHome_hover.Visible := False;
end;

end.
