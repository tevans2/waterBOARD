unit frmGraphView_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  VclTee.TeeGDIPlus, VclTee.TeEngine, VclTee.Series, VclTee.TeeProcs,
  VclTee.Chart, Vcl.StdCtrls, Vcl.ControlList, Vcl.Buttons, Math, Graph_u;

type
  TfrmGraphView = class(TForm)
    pnlHomePage: TPanel;
    Panel1: TPanel;
    shpGraph: TShape;
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
    cbbTimeFrame: TComboBox;
    imgAddReading: TImage;
    imgAddTarget: TImage;
    Panel4: TPanel;
    imgAddReadingHover: TImage;
    imgAddTargetHover: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure imgBackArrowMouseEnter(Sender: TObject);
    procedure imgHomeMouseEnter(Sender: TObject);
    procedure imgBackArrowHoverMouseLeave(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure imgBackArrowHoverClick(Sender: TObject);
    procedure imgHome_hoverMouseLeave(Sender: TObject);
    procedure imgHome_hoverClick(Sender: TObject);
    procedure imgAddTargetMouseEnter(Sender: TObject);
    procedure imgAddTargetHoverMouseLeave(Sender: TObject);
    procedure imgAddReadingHoverMouseLeave(Sender: TObject);
    procedure imgAddReadingMouseEnter(Sender: TObject);
  private
    { Private declarations }
    objGraph: TGraph;
  public
    { Public declarations }
    OrigionForm: integer;
  end;

var
  frmGraphView: TfrmGraphView;

implementation

{$R *.dfm}

uses frmHomePage_u, frmDamList_u, frmMapView_u, frmHomeLoggedIn_u;

procedure TfrmGraphView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // GUI CODE BEGIN
  frmHomePage.Close;
  // GUI CODE END
end;

procedure TfrmGraphView.FormResize(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgHome_hover.Left := imgHome.Left;
  imgHome_hover.Top := imgHome.Top;

  imgBackArrowHover.Left := imgBackArrow.Left;
  imgBackArrowHover.Top := imgBackArrow.Top;

  imgAddReadingHover.Left := imgAddReading.Left;
  imgAddTargetHover.Top := imgAddTarget.Top;

  frmHomePage.MasterWindowState := Self.WindowState;
  // GUI CODE END
end;

procedure TfrmGraphView.FormShow(Sender: TObject);
var
  dStartDate, dEndDate: TDate;
begin
  // GUI CODE BEGIN
  imgHome_hover.Visible := False;
  imgBackArrowHover.Visible := False;
  imgAddReadingHover.Visible := False;
  imgAddTargetHover.Visible := False;

  WindowState := frmHomePage.MasterWindowState;
  // GUI CODE END

  dStartDate := now;
  dEndDate := now;

  objGraph := TGraph.Create;
  objGraph.DisplayGraph(dStartDate, dEndDate)
end;

procedure TfrmGraphView.imgAddReadingHoverMouseLeave(Sender: TObject);
begin
  imgAddReadingHover.Hide;
end;

procedure TfrmGraphView.imgAddReadingMouseEnter(Sender: TObject);
begin
  imgAddReadingHover.Show;
end;

procedure TfrmGraphView.imgAddTargetHoverMouseLeave(Sender: TObject);
begin
  imgAddTargetHover.Hide;
end;

procedure TfrmGraphView.imgAddTargetMouseEnter(Sender: TObject);
begin
  imgAddTargetHover.Show;
end;

procedure TfrmGraphView.imgBackArrowHoverClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  case OrigionForm of
    1:
      frmDamList.Show;
    2:
      frmMapView.Show;
  end;

  Self.Hide;
  // GUI CODE END
end;

procedure TfrmGraphView.imgBackArrowHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgBackArrowHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmGraphView.imgBackArrowMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgBackArrowHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmGraphView.imgHomeMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgHome_hover.Visible := True;
  // GUI CODE END
end;

procedure TfrmGraphView.imgHome_hoverClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  case frmHomeLoggedIn.bLoggedIn of
    True:
      frmHomeLoggedIn.Show;
    False:
      frmHomePage.Show;
  end;

  Self.Hide;
  // GUI CODE END
end;

procedure TfrmGraphView.imgHome_hoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgHome_hover.Visible := False;
  // GUI CODE END
end;

end.
