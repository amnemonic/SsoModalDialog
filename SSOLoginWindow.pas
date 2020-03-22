{
MIT License

Copyright (c) 2020 [https://github.com/amnemonic * adam85mn_at_gmail.com]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
}

unit SSOLoginWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, SsoUtils;

type
  TMainForm = class(TForm)
    WebBrowser1: TWebBrowser;
    procedure FormShow(Sender: TObject);
    procedure WebBrowser1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
      var Cancel: WordBool);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    var
      SSO_URL : String;
      POST_SEARCH: String;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}



procedure TMainForm.FormCreate(Sender: TObject);
begin
  MainForm.POST_SEARCH:='SAMLResponse';
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  WebBrowser1.Navigate(SSO_URL);
end;

procedure TMainForm.WebBrowser1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData, Headers: OleVariant; var Cancel: WordBool);
  var PostStr:String;
begin
  PostStr:= SsoUtils.VariantToString(PostData);
  writeln('[URL]'+URL);
  if Pos(LowerCase(POST_SEARCH),LowerCase(PostStr))>0 then begin
    writeln('[SAML]'+PostStr);
    Cancel:=true; //Cancel further navigation
    MainForm.Close;
  end;
  
end;

end.
