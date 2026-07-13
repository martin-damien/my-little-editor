unit about;

{$mode ObjFPC}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

    { TAboutForm }

    TAboutForm = class(TForm)
        Image1: TImage;
        Label1: TLabel;
    private

    public

    end;

var
    AboutForm: TAboutForm;

implementation

{$R *.lfm}

end.

