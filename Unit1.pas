unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DSPack,DSUtil,DirectShow9, ExtCtrls, StdCtrls,inifiles;

type
  TForm1 = class(TForm)
    FilterGraph1: TFilterGraph;
    VideoWindow1: TVideoWindow;
    SampleGrabber1: TSampleGrabber;
    Filter1: TFilter;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.FormCreate(Sender: TObject);
var
  CamItem: TSysDevEnum;
begin
  FilterGraph1.Active := true;
  CamItem:= TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
  if CamItem.CountFilters > 0 then
  begin
    FilterGraph1.ClearGraph;
    FilterGraph1.Active:=false;
    Filter1.BaseFilter.Moniker:=CamItem.GetMoniker(0);
    FilterGraph1.Active:=true;
    with FilterGraph1 as ICaptureGraphBuilder2 do
    RenderStream(@PIN_CATEGORY_PREVIEW, nil, Filter1 as IBaseFilter, SampleGrabber1 as IBaseFilter, VideoWindow1 as IbaseFilter);
    FilterGraph1.Play;
    sleep(1500);
    SampleGrabber1.GetBitmap(Image1.Picture.Bitmap);
    image1.picture.SaveToFile('D:\1.bmp');
    exitprocess(0);
  end;
end;

end.
