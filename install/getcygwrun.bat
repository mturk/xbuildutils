@echo off
setlocal
rem
rem Licensed under the Apache License, Version 2.0 (the "License");
rem you may not use this file except in compliance with the License.
rem You may obtain a copy of the License at
rem
rem     http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.
rem
rem Download Cygwrun
rem
set "CygwrunVer=2.0.0"
rem
set "CurlOpts=-qkL --retry 5 --no-progress-meter"
set "_UtilsPath=C:\xbuildutils"
pushd %~dp0
set "_WorkPath=%cd%"
popd
rem
set "CygwrunName=cygwrun-%CygwrunVer%-win-x64"
set "CygwrunArch=%CygwrunName%.zip"
if not exist "%CygwrunArch%" (
    echo.
    echo Downloading %CygwrunArch% ...
    curl %CurlOpts% -o %CygwrunArch% https://github.com/mturk/cygwrun/releases/download/v%CygwrunVer%/%CygwrunArch%
)
rem
7za t %CygwrunArch% >NUL 2>&1 && ( goto Exp )
echo.
echo Failed to download %CygwrunArch%
del /F /Q %CygwrunArch% 2>NUL
exit /B 1
rem
:Exp
rem
rem Remove previous stuff
del /F /Q %_UtilsPath%\cygwrun.exe 2>NUL
pushd %_UtilsPath%
rem
7za x -y -bd %_WorkPath%\%CygwrunArch%
rem
popd
echo.
echo Finished.
:End
exit /B 0
