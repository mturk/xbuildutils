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
rem Dowloads ClamAV
rem
pushd %~dp0
set "_WorkPath=%cd%"
pushd ..\..\
set "PATH=%cd%;%PATH%"
popd
popd
rem Get versions
call %_WorkPath%\iversions.bat
rem
set "ClamAVName=clamav-%ClamAVVer%.win.x64"
set "ClamAVDist=clamav-%ClamAVBld%.win.x64"
set "ClamAVArch=%ClamAVDist%.zip"
if not exist "%ClamAVArch%" (
    echo.
    echo Downloading %ClamAVArch% ...
    curl %CurlOpts% -o %ClamAVArch% https://www.clamav.net/downloads/production/%ClamAVArch%
)
rem
7za t %ClamAVArch% >NUL 2>&1 && ( goto Exp )
echo.
echo Failed to download %ClamAVArch%
del /F /Q %ClamAVArch% 2>NUL
exit /B 1
rem
:Exp
rem
echo [%DATE% %TIME%] ClamAV : %ClamAVName% >>install.log
rem Remove previous stuff
rd /S /Q %_UtilsPath%\clamav\%ClamAVVer% 2>NUL
md %_UtilsPath%\clamav >NUL 2>&1
pushd %_UtilsPath%\clamav
rem Uncopress
7za x -bd %_WorkPath%\%ClamAVArch%
rem
move /Y %ClamAVName% %ClamAVVer% >NUL
copy /Y %_WorkPath%\freshclam.conf %ClamAVVer%\ >NUL
popd
echo.
echo Finished.
:End
exit /B 0
