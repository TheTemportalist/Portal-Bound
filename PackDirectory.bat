@echo off

for %%* in (.) do set CurrDirName=%%~nx*

echo Packing current folder...
"%ProgramFiles(x86)%\Steam\SteamApps\common\Starbound\win32\asset_packer.exe" "%cd%" "%CurrDirName%.pak"
echo Done.
pause