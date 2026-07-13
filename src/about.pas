{
  Copyright (c) 2026 MARTIN Damien

  SPDX-License-Identifier: MIT
}

unit about;

{$mode ObjFPC}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, LCLIntf,
    Buttons;

const
    APP_VERSION = '0.1.0 dev';
    APP_REPOSITORY_URL = 'https://github.com/martin-damien/my-little-editor';

type

    { TAboutForm }

    TAboutForm = class(TForm)
        BitBtn1: TBitBtn;
        Image1: TImage;
        Label1: TLabel;
        VersionLabel: TLabel;
        procedure BitBtn1Click(Sender: TObject);
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

end.

