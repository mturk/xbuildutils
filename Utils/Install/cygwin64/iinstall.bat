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
rem Dowload and install Cygwin ditribution
rem
rem
pushd %~dp0\..\..\
set "_UtilsPath=%cd%"
popd
rem
set "PATH=%_UtilsPath%;%PATH%"
set "CurlOpts=-qkL --retry 5 --no-progress-meter"
rem
set "CYGWMIRROR=https://mirrors.kernel.org/sourceware/cygwin/"
set "CYGWSETUPV=2.925"
set "CYGWINDLLV=3.4.6"
rem Figure out some sort of release build
set "CYGWSETUPB=1_%RANDOM%"
set "CYGWSETUPX=setup-x86_64-%CYGWSETUPV%.exe"
set "CYGWINROOT=%SystemDrive%\cygwin64"
set "CYGWSETUPM=D"
rem
if exist "%CYGWINROOT%\" goto :HasCygwinDir
echo Creating Cygwin setup from %CYGWMIRROR%
mkdir "%CYGWINROOT%" >NUL
goto :GetCygwinSetup
rem
:HasCygwinDir
if /i "x%~1" == "x/d" goto :RunUpdate
set "CYGWSETUPM=L"
echo Installing from local dir %CYGWINROOT%\.packages
goto :GetCygwinSetup
rem
:RunUpdate
echo Updating %CYGWINROOT%
rem
:GetCygwinSetup
pushd "%CYGWINROOT%"
if exist "%CYGWSETUPX%" goto :HasCygwinSetup
echo Downloading Cygwin setup
curl %CurlOpts% -o %CYGWSETUPX% https://cygwin.com/setup-x86_64.exe >NUL
if exist "%CYGWSETUPX%" goto :HasCygwinSetup
echo.
echo Failed to download Cygwin setup
exit /B 1
rem
:HasCygwinSetup
rem
rem Define required packages
rem
set "P0=curl,wget,wget2,gnupg,gnupg2,inetutils"
set "P1=diffutils,dos2unix,patch,patchutils,time,chere,cygrunsrv,attr,shutdown"
set "P2=python2,python3,tcl,git,subversion"
set "P3=cpio,unzip,xz,p7zip,zip,rpm,rpm-build"
set "P4=autoconf,automake,autogen,autobuild,libtool,m4,make,makedepend"
set "P5=bison,byacc,flex,cmake,ninja,meson"
set "P6=mingw64-x86_64-binutils,mingw64-x86_64-gcc-core,mingw64-x86_64-headers,mingw64-x86_64-runtime"
rem
set "PX=%P0%,%P1%,%P2%,%P3%,%P4%,%P5%,%P6%"
rem
echo.
start /B /MIN /WAIT %CYGWSETUPX% -qnoOABX%CYGWSETUPM% -l "%CYGWINROOT%\.packages" -s "%CYGWMIRROR%" -R "%CYGWINROOT%" -P "%PX%"
popd
rem
if exist "%CYGWINROOT%\.iinstall\" goto :HasInstallDir
mkdir "%CYGWINROOT%\.iinstall" >NUL
for %%i in (bashrc fstab history iinstall.bat cygwhere.bat) do (
  copy /Y /B %%i "%CYGWINROOT%\.iinstall\" >NUL
)
rem
:HasInstallDir
if /i "x%~1" == "x/z" goto :CreateDist
if "%CYGWSETUPM%" NEQ "L" goto :End
if exist "%CYGWINROOT%\etc\fstab.org" goto :End
rem Update fstab with noacl flag set
move /Y "%CYGWINROOT%\etc\fstab" "%CYGWINROOT%\etc\fstab.org" >NUL
copy /Y /B fstab "%CYGWINROOT%\etc\fstab" >NUL
copy /Y /B history "%CYGWINROOT%\etc\skel\.bash_history" >NUL
if /i "x%~1" == "x/b" goto :SetupBashrc
rem
goto :End
rem Add chere-like support for Total Commander or other shells
rem The first argument to cygwhere.bat is directory
rem that bash will cd to
:SetupBashrc
move /Y "%CYGWINROOT%\etc\skel\.bashrc" bashrc.org >NUL
copy /Y /B bashrc.org+bashrc "%CYGWINROOT%\etc\skel\.bashrc" >NUL
copy /Y /B cygwhere.bat "%CYGWINROOT%\" >NUL
goto :End
rem
:CreateDist
set "CYGWAARCH=cygwin64-%CYGWINDLLV%-%CYGWSETUPB%.tar.gz"
rem Use Windows tar utility
echo.
echo Creating %CYGWAARCH%
tar -czf %CYGWAARCH% "%CYGWINROOT%"
rem
:End
echo.
echo Finished.
exit /B 0
