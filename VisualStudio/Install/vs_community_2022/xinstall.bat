@echo off
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
rem
rem Offline Installer for Visual Studio 2022 Community
rem
rem
rem
setlocal
rem
pushd %~dp0
set "_WORKDIR=%cd%"
popd
rem
set "_DESTDIR=C:\Tools"
set "_VSPRODUCTVER=2022"
set "_VSPRODUCTBLD=17.3.4"
set "_VSINSTALLDIR=msvs2022c"
set "_VSINSTALLPKG=Packages"
set "_VSINSTALLTMP=Temp"
set "_MSCINSTALLER=vs_community.exe"
set "_SDKBASEDIR=Win10SDK_10.0.19041,version=10.0.19041.3"
set "_SDKPRODUCTWVER=10.0.19041.0"
set "_SDKPRODUCTNAME=19041"
set "_SKDINSTALLDIR=wsdk%_SDKPRODUCTNAME%"
rem
rd /S /Q %_VSINSTALLTMP% 2>NUL
md %_VSINSTALLTMP% 2>NUL
rem
set "TEMP=%_WORKDIR%\%_VSINSTALLTMP%"
set "TMP=%_WORKDIR%\%_VSINSTALLTMP%"
rem
md %_DESTDIR% 2>NUL
rem
if exist "%_DESTDIR%\%_SKDINSTALLDIR%" goto doVsInstall
rem Install vc_redist
echo.
echo Installing CRT Redistributables
start /wait vc_redist.x86.exe /install /quiet /norestart
start /wait vc_redist.x64.exe /install /quiet
rem
echo.
echo Installing Windows SDK %_SDKPRODUCTWVER%
echo This can take a while ...
pushd %_VSINSTALLPKG%\%_SDKBASEDIR%
start /wait WinSDKSetup.exe /installpath %_DESTDIR%\%_SKDINSTALLDIR% /ceip off /features OptionId.DesktopCPPx64 /q
popd
rem ping -n 6 localhost >NUL 2>&1
rem
:doVsInstall
echo.
if exist "%_DESTDIR%\%_VSINSTALLDIR%\xvcvars.bat" (
  echo Installation Error
  echo %_DESTDIR%\%_VSINSTALLDIR% directory already exist
  exit /B 1
)
echo Installing Visual Studio %_VSPRODUCTVER% %_VSPRODUCTBLD% Community
echo This can take a while ...
echo.
rem ping -n 6 localhost >NUL 2>&1
rem
pushd %_VSINSTALLPKG%
start /wait %_MSCINSTALLER% ^
--installPath "%_DESTDIR%\%_VSINSTALLDIR%" --locale en-US ^
--quiet --nocache --norestart --noWeb --wait >NUL
rem
if "%ERRORLEVEL%" NEQ "0" (
  echo %_MSCINSTALLER% failed with error %ERRORLEVEL%
  exit /B 1
)
rem
popd
xcopy /I /Y /Q xvcvars.* "%_DESTDIR%\%_VSINSTALLDIR%" >NUL
del /Q /F "%_DESTDIR%\%_VSINSTALLDIR%\Common7\Tools\vsdevcmd\ext\team_explorer.bat" >NUL 2>&1
rem
if /i "x%~1" NEQ "x/r" goto End
echo.
shutdown /r /t 30 /c "Restart after installing Visual Studio %_VSPRODUCTVER% %_VSPRODUCTBLD% Community"
rem
:End
echo Done
exit /B 0
