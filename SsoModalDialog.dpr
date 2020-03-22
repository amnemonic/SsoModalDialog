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

program SsoModalDialog;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  SysUtils,
  Forms,
  comobj,
  ActiveX,
  SSOLoginWindow in 'SSOLoginWindow.pas' {MainForm},
  ssoutils in 'ssoutils.pas';

procedure showHelp;
begin
  Writeln('');
  Writeln('Usage:');
  Writeln('  '+ExtractFileName(Application.ExeName)+' <SSO Url Address> [<SearchString>] [<SSO Title>]');
  Writeln('  '+ExtractFileName(Application.ExeName)+' <SSO Url Address> [<SearchString>] [<SSO Title>]');
end;


begin
  try
    if ParamCount=0 then begin
      Writeln('No URL Found');
      showHelp;
      ExitCode:=1; Exit;
    end;

    Writeln('[START]' + IntToStr(ParamCount));
    CoInitialize(nil);
    Application.CreateForm(TMainForm, MainForm);
    if ParamCount>=1 then MainForm.SSO_URL    :=ParamStr(1);
    if ParamCount>=2 then MainForm.POST_SEARCH:=ParamStr(2);
    if ParamCount>=3 then MainForm.Caption    :=ParamStr(3);
    MainForm.ShowModal;

    Writeln('[EXIT]');
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
