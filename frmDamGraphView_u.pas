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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDamGraph: TfrmDamGraph;

implementation

{$R *.dfm}

uses frmHomePage_u;

procedure TfrmDamGraph.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmHomePage.close;
end;

procedure TfrmDamGraph.FormShow(Sender: TObject);
begin
  imgHomeHover.Visible := False;
  imgBackArrowHover.Visible := False;
end;

procedure TfrmDamGraph.imgBackArrowHoverMouseLeave(Sender: TObject);
begin
  imgBackArrowHover.Visible := False;
end;

procedure TfrmDamGraph.imgBackArrowMouseEnter(Sender: TObject);
begin
  imgBackArrowHover.Visible := True;
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
