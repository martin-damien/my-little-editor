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
        GitHubBitBtn: TBitBtn;
        IconSetWebBitBtn: TBitBtn;
        EditorWebBitBtn: TBitBtn;
        Image1: TImage;
        ApplicationNameLabel: TLabel;
        IconSetNameLabel: TLabel;
        IconSetAuthorLabel: TLabel;
        IconSetLicenseLabel: TLabel;
        EditorNameLabel: TLabel;
        EditorAuthorLabel: TLabel;
        EditorLicenseLabel: TLabel;
        AboutPageControl: TPageControl;
        MleTabSheet: TTabSheet;
        CreditsTabSheet: TTabSheet;
        VersionLabel: TLabel;
        procedure GitHubBitBtnClick(Sender: TObject);
        procedure IconSetWebBitBtnClick(Sender: TObject);
        procedure EditorWebBitBtnClick(Sender: TObject);
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

procedure TAboutForm.GitHubBitBtnClick(Sender: TObject);
begin
    OpenUrl(APP_REPOSITORY_URL);
end;

procedure TAboutForm.IconSetWebBitBtnClick(Sender: TObject);
begin
    OpenUrl(ICONS_WEBSITE_URL);
end;

procedure TAboutForm.EditorWebBitBtnClick(Sender: TObject);
begin
    OpenUrl(RICHMEMO_REPOSITORY_URL);
end;

end.

