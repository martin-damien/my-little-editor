unit main;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
    ComCtrls, Buttons, Menus, RichMemo, SynHighlighterPHP;

type

    TEditorStatus = (esNew, esLoaded, esModified, esSaved);

    { TMainForm }

    TMainForm = class(TForm)
        EditorRichMemo: TRichMemo;
        IconImageList: TImageList;
        MainMenu: TMainMenu;
        FileMenuItem: TMenuItem;
        AboutMenuItem: TMenuItem;
        OpenDialog: TOpenDialog;
        SaveDialog: TSaveDialog;
        StatusBar: TStatusBar;
        MainToolBar: TToolBar;
        NewToolButton: TToolButton;
        OpenToolButton: TToolButton;
        SaveToolButton: TToolButton;
        PrintToolButton: TToolButton;
        procedure EditorRichMemoChange(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure OpenToolButtonClick(Sender: TObject);
        procedure SaveToolButtonClick(Sender: TObject);

        private
            procedure OpenFile(filename: String);
            procedure SaveToFile;
            procedure UpdateStatusBar;

    end;

var
    editorStatus: TEditorStatus;
    rtfFile: TFileStream;
    MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.OpenFile(filename: String);
begin
    EditorRichMemo.LoadRichText(rtfFile);
    editorStatus := esLoaded;
    UpdateStatusBar;
end;

procedure TMainForm.SaveToFile;
begin
    rtfFile.Position := 0; { Rewind stream (if not, it will append) }
    EditorRichMemo.SaveRichText(rtfFile);
    editorStatus := esSaved;
    UpdateStatusBar;
end;

procedure TMainForm.UpdateStatusBar;
begin
    if editorStatus = esNew then
        StatusBar.Panels[0].Text := 'New'
    else if editorStatus = esLoaded then
        StatusBar.Panels[0].Text := 'Loaded'
    else if editorStatus = esModified then
        StatusBar.Panels[0].Text := 'Modified'
    else
        StatusBar.Panels[0].Text := 'Saved';
end;

procedure TMainForm.SaveToolButtonClick(Sender: TObject);
begin
    if rtfFile <> nil then
    begin
        SaveToFile;
        Exit;
    end;

    if SaveDialog.Execute then
        begin
            rtfFile := TFileStream.Create(OpenDialog.FileName, fmCreate or fmOpenReadWrite);
            SaveToFile;
        end;
end;

procedure TMainForm.OpenToolButtonClick(Sender: TObject);
begin
    if OpenDialog.Execute then
        begin
            rtfFile := TFileStream.Create(OpenDialog.FileName, fmOpenReadWrite);
            OpenFile(OpenDialog.FileName);
        end;
end;

procedure TMainForm.EditorRichMemoChange(Sender: TObject);
begin
    editorStatus := esModified;
    UpdateStatusBar;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    editorStatus := esNew;
    UpdateStatusBar;
end;

end.

