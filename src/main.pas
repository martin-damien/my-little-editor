unit main;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
    ComCtrls, Buttons, Menus, RichMemo, SynHighlighterPHP;

type

    { TMainForm }

    TMainForm = class(TForm)
        EditorRichMemo: TRichMemo;
        IconImageList: TImageList;
        MainMenu: TMainMenu;
        FileMenuItem: TMenuItem;
        AboutMenuItem: TMenuItem;
        OpenDialog: TOpenDialog;
        SaveDialog: TSaveDialog;
        StatusBar1: TStatusBar;
        MainToolBar: TToolBar;
        NewToolButton: TToolButton;
        OpenToolButton: TToolButton;
        SaveToolButton: TToolButton;
        PrintToolButton: TToolButton;
        procedure OpenToolButtonClick(Sender: TObject);
        procedure SaveToolButtonClick(Sender: TObject);

        private

        public

    end;

var
    rtfFile: TFileStream;
    MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.SaveToolButtonClick(Sender: TObject);
begin
    if rtfFile <> nil then
        EditorRichMemo.SaveRichText(rtfFile)
    else
        if SaveDialog.Execute then
            begin
                rtfFile := TFileStream.Create(OpenDialog.FileName, fmCreate or fmOpenReadWrite);
                EditorRichMemo.SaveRichText(rtfFile)
            end
        else
            ShowMessage('No file selected');
end;

procedure TMainForm.OpenToolButtonClick(Sender: TObject);
begin
    if OpenDialog.Execute then
        begin
            rtfFile := TFileStream.Create(OpenDialog.FileName, fmOpenReadWrite);
            EditorRichMemo.LoadRichText(rtfFile);
        end
    else
        ShowMessage('No file selected');
end;

end.

