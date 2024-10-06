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
rem Download Cygwin ditribution
rem
rem
set "CygwinRoot=%SystemDrive%\cygwin64"
rem
set "CurlOpts=-qkL --retry 5 --no-progress-meter"
pushd %~dp0
set "_WorkPath=%cd%"
pushd ..\..\utils
set "PATH=%cd%;%PATH%"
popd
popd
rem
call cygwinconf.bat
rem
rem
rem Check if already installed
if exist %CygwinRoot% (
  echo Error: Cygwin Root "%CygwinRoot%" already exists
  exit /B 1
)
md %CygwinRoot% >NUL
pushd %CygwinRoot%
echo Downloading Cygwin setup
curl.exe %CurlOpts% -o %CygwinSetup% https://cygwin.com/setup-x86_64.exe
rem
if not exist "%CygwinSetup%" (
  echo.
  echo Failed to download Cygwin setup
  exit /B 1
)
rem
start /B /MIN /WAIT %CygwinSetup% -qnoOABXD -l "%CygwinRoot%\.packages" -s "%CygwinMirror%" -R "%CygwinRoot%" -P "%CygwinPackages%"
popd
rem
robocopy . %CygwinRoot%\.install fstab cygwhere.bat cygwinconf.bat cygwininstall.bat >NUL
rem
if /i "x%~1" NEQ "x/d" goto End
rem
set "CygwinArchive=cygwin64-%CygwinVersion%.tar"
rem Use Windows tar utility
echo.
echo Creating %CygwinArchive%
%SystemRoot%\System32\tar.exe -cf %CygwinArchive% %CygwinRoot%
rem
:End
echo.
echo Finished.
exit /B 0
