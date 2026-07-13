{
    Copyright (c) 2026 MARTIN Damien

    SPDX-License-Identifier: MIT
}

unit about;

{$mode ObjFPC}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, LCLIntf,
    Buttons, ComCtrls, LCLTranslator, DefaultTranslator;

const
    APP_VERSION = '0.1.0 dev';
    APP_REPOSITORY_URL = 'https://github.com/martin-damien/my-little-editor';
    ICONS_WEBSITE_URL = 'https://p.yusukekamiyamane.com/';
    RICHMEMO_REPOSITORY_URL = 'https://github.com/skalogryz/richmemo';

type

    { TAboutForm }

    TAboutForm = class(TForm)
        BitBtn1: TBitBtn;
        BitBtn2: TBitBtn;
        BitBtn3: TBitBtn;
        Image1: TImage;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        Label6: TLabel;
        Label7: TLabel;
        PageControl1: TPageControl;
        TabSheet1: TTabSheet;
        TabSheet2: TTabSheet;
        VersionLabel: TLabel;
        procedure BitBtn1Click(Sender: TObject);
        procedure BitBtn2Click(Sender: TObject);
        procedure BitBtn3Click(Sender: TObject);
        procedure FormCreate(Sender: TObject);
    private

    public

    end;

var
    AboutForm: TAboutForm;

implementation

{$R *.lfm}

{ TAboutForm }

procedure TAboutForm.FormCreate(Sender: TObject);
begin
    VersionLabel.Caption := 'Version ' + APP_VERSION;
end;

procedure TAboutForm.BitBtn1Click(Sender: TObject);
begin
    OpenUrl(APP_REPOSITORY_URL);
end;

procedure TAboutForm.BitBtn2Click(Sender: TObject);
begin
    OpenUrl(ICONS_WEBSITE_URL);
end;

procedure TAboutForm.BitBtn3Click(Sender: TObject);
begin
    OpenUrl(RICHMEMO_REPOSITORY_URL);
end;

end.

