unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdTCPConnection, IdTCPClient, IdHTTP,
  IdBaseComponent, IdComponent, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    btnPost: TButton;
    IdHTTP1: TIdHTTP;
    procedure FormCreate(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnPostClick(Sender: TObject);
var
  postStream: TStringStream;
  AEnctryRespose: string;
  url: string;
  aEnctryPost: string;
begin
  url := 'https:/xxx.xx';
  aEnctryPost := '{"username":"test","password":"1"}';
  postStream := TStringStream.Create(aEnctryPost);
  try
    postStream.Position := 0;
    AEnctryRespose := IdHTTP1.Post(url, postStream);
    ShowMessage(AEnctryRespose);//post后的返回内容
  finally
    IdHTTP1.Disconnect;
    FreeAndNil(postStream);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  IdHTTP1 := TIdHTTP.Create(nil);
  IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IdHTTP1.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
  IdHTTP1.HandleRedirects := True;
  IdHTTP1.Request.ContentType := 'application/json';//设置交互方式为json格式
end;

end.
