{
  Copyright (c) 2026 MARTIN Damien

  SPDX-License-Identifier: MIT
}

program editor;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, printer4lazarus,
  main, about;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
    Application.Scaled:=True;
  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar:=True;
  {$POP}
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
    Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.

