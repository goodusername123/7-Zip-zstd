@echo off

REM Microsoft Windows SDK 7.1    (VC=sdk71) -> can compile for IA64, but who needs that?
REM Microsoft Visual Studio 2010 (VC=10.0) -> for win2k, but who needs that?
REM Microsoft Visual Studio 2012 (VC=11.0)
REM Microsoft Visual Studio 2013 (VC=12.0)
REM Microsoft Visual Studio 2015 (VC=14.0)
REM Microsoft Visual Studio 2019 (VC=15.0)
REM Microsoft Visual Studio 2019 (VC=16.0)

REM Microsoft Visual Studio 2019 /SUBSYSTEM version numbers:
REM             MIN                                  STANDARD
REM CONSOLE     5.01 (x86) 5.02 (x64) 6.02 (ARM)     6.00 (x86, x64) 6.02 (ARM)
REM WINDOWS     5.01 (x86) 5.02 (x64) 6.02 (ARM)     6.00 (x86, x64) 6.02 (ARM)


REM to many vcvarsall.cmd calls will blow it up!
set OPATH=%PATH%
set ERRFILE=%APPVEYOR_BUILD_FOLDER%\error.txt
cd %APPVEYOR_BUILD_FOLDER%\CPP

REM VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\^M
set SUBSYS=5.01
set PATH=%OPATH%
call "%VCINSTALLDIR%\Auxiliary\Build\vcvarsall.bat" x86
call build-it.cmd
goto end

set SUBSYS=5.02
set PATH=%OPATH%
call "%VCINSTALLDIR%\Auxiliary\Build\vcvarsall.bat" x64
call build-it.cmd

set SUBSYS=6.02
set PATH=%OPATH%
call "%VCINSTALLDIR%\Auxiliary\Build\vcvarsall.bat" x64_arm
call build-it.cmd

set SUBSYS=6.02
set PATH=%OPATH%
call "%VCINSTALLDIR%\Auxiliary\Build\vcvarsall.bat" x64_arm64
call build-it.cmd

:end
cd %APPVEYOR_BUILD_FOLDER%
7z a %APPVEYOR_PROJECT_NAME%-%APPVEYOR_BUILD_VERSION%.7z bin-* *.txt
