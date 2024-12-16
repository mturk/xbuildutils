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
rem
rem Offline Installer for Visual Studio 2022 LTSC Build Tools
rem
rem
set "_VSPRODUCTVER=2022"
set "_VSPRODUCTBLD=17.10.9_LTSC"
set "_SDKBASEDIR=Win11SDK_10.0.22621,version=10.0.22621.6,productarch=neutral"
set "_SDKPRODUCTWVER=10.0.22621.6"
rem
pushd %~dp0
set "_WORKDIR=%cd%"
popd
rem
set "_XbuildUtilsDir=C:\xbuildutils"
set "_VSINSTALLDIR=msvs"
set "_VSINSTALLPKG=Packages"
set "_VSINSTALLTMP=Temp"
set "_MSCINSTALLER=vs_buildtools.exe"
set "_SKDINSTALLDIR=wsdk"
rem
rd /S /Q %_VSINSTALLTMP% 2>NUL
md %_VSINSTALLTMP% 2>NUL
rem
set "TEMP=%_WORKDIR%\%_VSINSTALLTMP%"
set "TMP=%_WORKDIR%\%_VSINSTALLTMP%"
rem
md %_XbuildUtilsDir% 2>NUL
rem
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
start /wait WinSDKSetup.exe /installpath %_XbuildUtilsDir%\%_SKDINSTALLDIR% /ceip off /features OptionId.DesktopCPPx64 /q
if "%ERRORLEVEL%" NEQ "0" (
  echo WinSDKSetup.exe failed with error %ERRORLEVEL%
  exit /B 1
)
popd
rem
echo.
echo Installing Visual Studio %_VSPRODUCTVER% %_VSPRODUCTBLD% Build Tools
echo This can take a while ...
echo.
rem
pushd %_VSINSTALLPKG%
start /wait %_MSCINSTALLER% ^
--installPath "%_XbuildUtilsDir%\%_VSINSTALLDIR%" --locale en-US ^
--quiet --nocache --norestart --noWeb --wait >NUL
rem
if "%ERRORLEVEL%" NEQ "0" (
  echo %_MSCINSTALLER% failed with error %ERRORLEVEL%
  exit /B 1
)
rem
popd
robocopy . %_XbuildUtilsDir%\%_VSINSTALLDIR% README.txt msvsvars.bat msvsvars.sh >NUL
del /Q /F "%_XbuildUtilsDir%\%_VSINSTALLDIR%\Common7\Tools\vsdevcmd\ext\team_explorer.bat" >NUL 2>&1
rem
echo Done
exit /B 0
