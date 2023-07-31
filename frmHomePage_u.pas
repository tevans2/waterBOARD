unit frmHomePage_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.Threading,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Math,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, frmDamList_u, frmMapView_u, frmLogin_u,
  frmSignUp_u, frmHomeLoggedIn_u, clsDamReading_u, frmLoadingPage_u;

type
  TfrmHomePage = class(TForm)
    pnlHomePage: TPanel;
    Shape1: TShape;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Image1: TImage;
    Panel4: TPanel;
    imgDamList: TImage;
    imgMapView: TImage;
    imgSignUp: TImage;
    imgLogin: TImage;
    Shape2: TShape;
    imgDamListHover: TImage;
    imgMapViewHover: TImage;
    imgSignUpHover: TImage;
    imgLoginHover: TImage;
    procedure FormResize(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure imgLoginMouseEnter(Sender: TObject);
    procedure imgLoginHoverMouseLeave(Sender: TObject);
    procedure imgMapViewMouseEnter(Sender: TObject);
    procedure imgMapViewHoverMouseLeave(Sender: TObject);
    procedure imgSignUpMouseEnter(Sender: TObject);
    procedure imgSignUpHoverMouseLeave(Sender: TObject);
    procedure imgDamListMouseEnter(Sender: TObject);
    procedure imgDamListHoverMouseLeave(Sender: TObject);
    procedure imgDamListHoverClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgMapViewHoverClick(Sender: TObject);
    procedure imgLoginHoverClick(Sender: TObject);
    procedure imgSignUpHoverClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    bFetched: Boolean;
  public
    { Public declarations }
    MasterWindowState: TWindowState;
    objDamReading: TDamReading;
  end;

var
  frmHomePage: TfrmHomePage;

implementation

{$R *.dfm}

procedure TfrmHomePage.FormCreate(Sender: TObject);
begin
  bFetched := False;
end;

procedure TfrmHomePage.FormResize(Sender: TObject);
var
  Ratio: Real;
begin
  // GUI CODE BEGIN
  Ratio := min(ClientWidth / pnlHomePage.Width,
    ClientHeight / pnlHomePage.Height);
  pnlHomePage.ScaleBy(Trunc(Ratio * 100), 100);

  frmHomePage.MasterWindowState := Self.WindowState;
  // GUI CODE END
end;

procedure TfrmHomePage.FormShow(Sender: TObject);
var
  aTask: ITask;
  arrDamData: TArray<Real>;
  sOutput: String;
  dReadingDate: TDate;
  sHTMLTable: String;
  i: integer;

begin
  // Set the window state based on the MasterWindowState of frmHomePage
  WindowState := frmHomePage.MasterWindowState;
  // Set bLoggedIn property of frmHomeLoggedIn to false indicating that user is not logged in
  frmHomeLoggedIn.bLoggedIn := False;

  // Create a new instance of TDamReading
  objDamReading := TDamReading.Create;

  // Create a new task
  aTask := TTask.Create(
    procedure
    begin
      // Initialize arrDamData array with size 6
      SetLength(arrDamData, 6);

      // Fetch dam reading data from the web
      with objDamReading do
      begin
        try
          // Fetch the HTML table data
          sHTMLTable := FetchTable;
          // Get the dam levels from the fetched HTML table
          arrDamData := FetchDamLevels(sHTMLTable);
          // Get the reading date from the fetched HTML table
          dReadingDate := FetchReadingDate(sHTMLTable);
          // Delay the execution for 5 seconds
          sleep(5000);
          // Set the visibility of the tick image on the loading page to true
          frmLoadingPage.imgTick.Visible := True;

          // Hide the loading image on the loading page
          frmLoadingPage.imgLoading.Visible := False;

        except
          // Show error message when unable to fetch the latest dam data
          Showmessage('Unable to fetch latest dam data.');
        end;

        // Synchronize the following block of code to the main thread
        TThread.Synchronize(TThread.Current,
          procedure
          begin
            try
              // Check if the fetched reading date is already in the database
              if not CheckReadingDateInTable(dReadingDate) then
                // If not, insert the daily dam readings to the database
                InsertDailyDamReadings(dReadingDate, arrDamData);
              // Set bFetched to true, indicating the data has been fetched successfully
              bFetched := True;
              // Refresh the loading page
              frmLoadingPage.Refresh;
            except
              // Show error message when unable to fetch the latest dam data
              Showmessage('Unable to fetch latest dam data.');
              Exit
            end;
          end);
        // Refresh the loading page again
        frmLoadingPage.Refresh;
        // Close the loading page
        frmLoadingPage.Close;
      end;
    end);

  // If the data has not been fetched, start the task and show the loading page
  if bFetched = False then
  begin
    aTask.Start;
    frmLoadingPage.ShowModal;
  end;

end;

procedure TfrmHomePage.imgDamListHoverClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  frmDamList.Show;
  Self.Hide;
  // GUI CODE END

end;

procedure TfrmHomePage.imgDamListHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN

  imgDamList.Visible := True;
  imgDamListHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmHomePage.imgLoginHoverClick(Sender: TObject);
begin
  // GUI CODE BEGIN

  frmLogin.Show;
  // GUI CODE END
end;

procedure TfrmHomePage.imgLoginHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgLogin.Visible := True;
  imgLoginHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmHomePage.imgLoginMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgLogin.Visible := False;
  imgLoginHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmHomePage.imgMapViewHoverClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  frmMapView.Show;
  Self.Hide;
  // GUI CODE END
end;

procedure TfrmHomePage.imgMapViewHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgMapView.Visible := True;
  imgMapViewHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmHomePage.imgMapViewMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgMapView.Visible := False;
  imgMapViewHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmHomePage.imgSignUpHoverClick(Sender: TObject);
begin
  // GUI CODE BEGIN
  frmSignUp.Show;
  // GUI CODE END
end;

procedure TfrmHomePage.imgSignUpHoverMouseLeave(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgSignUp.Visible := True;
  imgSignUpHover.Visible := False;
  // GUI CODE END
end;

procedure TfrmHomePage.imgSignUpMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgSignUp.Visible := False;
  imgSignUpHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmHomePage.imgDamListMouseEnter(Sender: TObject);
begin
  // GUI CODE BEGIN
  imgDamList.Visible := False;
  imgDamListHover.Visible := True;
  // GUI CODE END
end;

procedure TfrmHomePage.Panel1Resize(Sender: TObject);
var
  Ratio: Real;
begin
  // GUI CODE BEGIN
  Ratio := min(Panel1.Width / Panel4.Width, Panel1.Height / Panel4.Height);
  Panel4.ScaleBy(Trunc(Ratio * 100), 100);

  with Panel4 do
  begin
    Left := (Panel1.Width - Width) div 2;
    Top := (Panel1.Height - Height) div 2;
  end;
  // GUI CODE END
end;

end.
