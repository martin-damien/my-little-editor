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
        SaveMenuItem: TMenuItem;
        OpenMenuItem: TMenuItem;
        NewMenuItem: TMenuItem;
        OpenDialog: TOpenDialog;
        SaveDialog: TSaveDialog;
        StatusBar: TStatusBar;
        MainToolBar: TToolBar;
        NewToolButton: TToolButton;
        OpenToolButton: TToolButton;
        SaveToolButton: TToolButton;
        PrintToolButton: TToolButton;

        procedure FormCreate(Sender: TObject);

        { Generic EventHandler to be plugged with toolbar and menu }

        procedure DoNew(Sender: TObject);
        procedure DoOpen(Sender: TObject);
        procedure DoSave(Sender: TObject);
        procedure OnRichMemoChanged(Sender: TObject);

        private

            procedure UpdateWindowCaption;
            procedure UpdateStatusBar;

    end;

var
    editorStatus: TEditorStatus;
    fileName: String;
    rtfFile: TFileStream;
    MainForm: TMainForm;

implementation

{$R *.lfm}

{ ================================================================== TMainForm }

{ Init ----------------------------------------------------------------------- }

procedure TMainForm.FormCreate(Sender: TObject);
begin
    fileName := 'Untitled file';
    editorStatus := esNew;
    UpdateWindowCaption;
    UpdateStatusBar;
end;

{ Events Handlers ------------------------------------------------------------ }

procedure TMainForm.DoNew(Sender: TObject);
begin

end;

procedure TMainForm.DoOpen(Sender: TObject);
begin
    if OpenDialog.Execute then
        begin
            rtfFile := TFileStream.Create(OpenDialog.FileName, fmOpenReadWrite);
            fileName := OpenDialog.FileName;
            EditorRichMemo.LoadRichText(rtfFile);
            editorStatus := esLoaded;
            UpdateWindowCaption;
            UpdateStatusBar;
        end;
end;

procedure TMainForm.DoSave(Sender: TObject);
var
    newFileName: String;
begin
    if rtfFile = nil then
        if SaveDialog.Execute then
        begin
            newFileName := SaveDialog.FileName;

            { Add RTF extension if not already done }
            if not newFileName.EndsWith('.rtf') then
                newFileName := newFileName + '.rtf';

            rtfFile := TFileStream.Create(newFileName, fmCreate or fmOpenReadWrite);
            fileName := newFileName;
        end;

    if rtfFile <> nil then
    begin
        rtfFile.Position := 0; { Rewind stream (if not, it will append) }
        EditorRichMemo.SaveRichText(rtfFile);
        editorStatus := esSaved;
        UpdateStatusBar;
    end;
end;

procedure TMainForm.OnRichMemoChanged(Sender: TObject);
begin
    editorStatus := esModified;
    UpdateStatusBar;
end;

{ Private members ------------------------------------------------------------ }

procedure TMainForm.UpdateWindowCaption;
begin
    MainForm.Caption := 'Editor - ' + fileName;
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

end.

