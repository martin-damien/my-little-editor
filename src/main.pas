unit main;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
    ComCtrls, Buttons, Menus, RichMemo, SynHighlighterPHP, PrintersDlgs, LCLType;

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
        BoldToolButton: TToolButton;
        SeparatorToolButton1: TToolButton;
        ItalicToolButton: TToolButton;
        UnderlineToolButton: TToolButton;

        procedure BoldToolButtonClick(Sender: TObject);
        procedure OnRichMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure FormCreate(Sender: TObject);

        { Generic EventHandler to be plugged with toolbar and menu }

        procedure DoNew(Sender: TObject);
        procedure DoOpen(Sender: TObject);
        procedure DoSave(Sender: TObject);
        procedure ItalicToolButtonClick(Sender: TObject);
        procedure OnRichMemoChanged(Sender: TObject);
        procedure OnRichMemoClicked(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        procedure UnderlineToolButtonClick(Sender: TObject);

        private

            procedure SwitchSelectionTextAttribute(attribute: TFontStyle);
            procedure UpdateWindowCaption;
            procedure UpdateStatusBar;
            procedure UpdateToolBar;

    end;

var
    editorStatus: TEditorStatus;
    fileName: String;
    rtfFile: TFileStream;
    MainForm: TMainForm;
    selectionFontFormat: TFontParams;

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

procedure TMainForm.BoldToolButtonClick(Sender: TObject);
begin
    SwitchSelectionTextAttribute(fsBold);
end;

procedure TMainForm.OnRichMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if key in [VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN] then
    begin
        EditorRichMemo.GetTextAttributes(EditorRichMemo.SelStart, selectionFontFormat);
        UpdateToolBar;
    end;
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

procedure TMainForm.ItalicToolButtonClick(Sender: TObject);
begin
    SwitchSelectionTextAttribute(fsItalic);
end;

procedure TMainForm.OnRichMemoChanged(Sender: TObject);
begin
    editorStatus := esModified;
    UpdateStatusBar;
end;

procedure TMainForm.OnRichMemoClicked(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    EditorRichMemo.GetTextAttributes(EditorRichMemo.SelStart, selectionFontFormat);
    UpdateToolBar;
end;

procedure TMainForm.UnderlineToolButtonClick(Sender: TObject);
begin
    SwitchSelectionTextAttribute(fsUnderline);
end;

{ Private members ------------------------------------------------------------ }

procedure TMainForm.SwitchSelectionTextAttribute(attribute: TFontStyle);
begin
    if attribute in selectionFontFormat.Style = False then
        selectionFontFormat.Style := selectionFontFormat.Style + [attribute]
    else
        selectionFontFormat.Style := selectionFontFormat.Style - [attribute];

    EditorRichMemo.SetTextAttributes(EditorRichMemo.SelStart, EditorRichMemo.SelLength, selectionFontFormat);
end;

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

procedure TMainForm.UpdateToolBar;
begin
    BoldToolButton.Down := fsBold in selectionFontFormat.Style;
    ItalicToolButton.Down := fsItalic in selectionFontFormat.Style;
    UnderlineToolButton.Down := fsUnderline in selectionFontFormat.Style;
end;

end.

