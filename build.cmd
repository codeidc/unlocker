@echo off

REM Read current version
set /p VERSION=<VERSION
echo package vmwpatch > .\vmwpatch\version.go
echo const VERSION = "%VERSION%" >> .\vmwpatch\version.go

echo Building release executables - %VERSION%

if not exist .\build\ISO mkdir .\build\ISO
if not exist .\build\linux mkdir .\build\linux
if not exist .\build\windows mkdir .\build\windows

pushd .\commands\check
echo Building check
go-winres make --arch amd64 --product-version %VERSION% --file-version %VERSION%
set GOOS=windows
set GOARCH=amd64
go build -o ..\..\build\windows\check.exe
set GOOS=linux
set GOARCH=amd64
go build -o ..\..\build\linux\check
del /q rsrc_windows_amd64.syso
popd

pushd .\commands\relock
echo Building relock
go-winres make --arch amd64 --product-version %VERSION% --file-version %VERSION%
set GOOS=windows
set GOARCH=amd64
go build -o ..\..\build\windows\relock.exe
set GOOS=linux
set GOARCH=amd64
go build -o ..\..\build\linux\relock
del /q rsrc_windows_amd64.syso
popd

pushd .\commands\dumpsmc
echo Building dumpsmc
go-winres make --arch amd64 --product-version %VERSION% --file-version %VERSION%
set GOOS=windows
set GOARCH=amd64
go build -o ..\..\build\windows\dumpsmc.exe
set GOOS=linux
set GOARCH=amd64
go build -o ..\..\build\linux\dumpsmc
del /q rsrc_windows_amd64.syso
popd

pushd .\commands\unlock
echo Building unlock
go-winres make --arch amd64 --product-version %VERSION% --file-version %VERSION%
set GOOS=windows
set GOARCH=amd64
go build -o ..\..\build\windows\unlock.exe
set GOOS=linux
set GOARCH=amd64
go build -o ..\..\build\linux\unlock
del /q rsrc_windows_amd64.syso
popd

pushd .\commands\hostcaps
echo Building hostcaps
go-winres make --arch amd64 --product-version %VERSION% --file-version %VERSION%
set GOOS=windows
set GOARCH=amd64
go build -o ..\..\build\windows\hostcaps.exe
set GOOS=linux
set GOARCH=amd64
go build -o ..\..\build\linux\hostcaps
del /q rsrc_windows_amd64.syso
popd

xcopy /R /Y LICENSE .\build\
xcopy /R /Y *.md .\build\
xcopy /R /Y cpuid\linux\cpuid .\build\linux\
xcopy /R /Y cpuid\windows\cpuid.exe .\build\windows\
xcopy /E /F /I /R /Y ISO .\build\ISO\
