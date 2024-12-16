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
rem Create offline Installer for Visual Studio 2022 LTSC Build Tools
rem
rem
set "_VSPRODUCTVER=2022"
set "_VSPRODUCTBLD=17.10.9_LTSC"
rem
pushd %~dp0
set "_WORKDIR=%cd%"
pushd ..\..\utils
set "PATH=%cd%;%PATH%"
popd
popd
set "CurlOpts=-qkL --retry 5 --no-progress-meter"
rem
set "_XbuildUtilsDir=C:\xbuildutils"
set "_VSINSTALLDIR=msvs"
set "_VSINSTALLPKG=Packages"
set "_VSINSTALLTMP=Temp"
set "_MSCINSTALLER=vs_buildtools.exe"
set "_VSINSTALLOUT=vs_buildtools_%_VSPRODUCTVER%_%_VSPRODUCTBLD%"
set "_VSLAYOUTBASE=%_XbuildUtilsDir%\temp"
set "_VSLAYOUTDIST=%_VSLAYOUTBASE%\%_VSINSTALLDIR%"
rem
echo.
echo Creating Visual Studio %_VSPRODUCTVER% %_VSPRODUCTBLD% Build Tools offline distribution
echo This can take a while ...
echo.
rem
rd /S /Q %_VSLAYOUTDIST% 2>NUL
rd /S /Q %_VSINSTALLTMP% 2>NUL
md %_VSINSTALLTMP% 2>NUL
rem
set "TEMP=%_WORKDIR%\%_VSINSTALLTMP%"
set "TMP=%_WORKDIR%\%_VSINSTALLTMP%"
pushd %_VSINSTALLTMP%
rem
rem Download vs_build tools
rem https://learn.microsoft.com/en-us/visualstudio/releases/2022/release-history
rem
curl.exe %CurlOpts% -o %_MSCINSTALLER% ^
https://download.visualstudio.microsoft.com/download/pr/4ae9ea68-8765-4182-8d40-577ce66203b5/14419bae89be9115f47610909a01bd55e75e2581b3abc3016c52728049c75d38/vs_BuildTools.exe

if not exist "%_MSCINSTALLER%" (
  echo Missing %_MSCINSTALLER%
  exit /B 1
)
rem
start /wait %_MSCINSTALLER% --layout "%_VSLAYOUTDIST%\%_VSINSTALLPKG%" ^
--add Microsoft.VisualStudio.Workload.VCTools;includeRecommended ^
--locale en-US ^
--quiet --norestart --wait >NUL
rem
if "%ERRORLEVEL%" NEQ "0" (
  echo %_MSCINSTALLER% failed with error %ERRORLEVEL%
  exit /B 1
)
rem
popd
robocopy . %_VSLAYOUTDIST% README.txt msvsinstall.bat msvsvars.bat msvsvars.sh >NUL
copy /Y xresponse.json %_VSLAYOUTDIST%\%_VSINSTALLPKG%\Response.json >NUL
rem
echo Downloading latest CRT Redistributables
curl.exe %CurlOpts% -o %_VSLAYOUTDIST%\vc_redist.x64.exe https://aka.ms/vs/17/release/vc_redist.x64.exe
curl.exe %CurlOpts% -o %_VSLAYOUTDIST%\vc_redist.x86.exe https://aka.ms/vs/17/release/vc_redist.x86.exe
rem
rd /S /Q %_VSINSTALLTMP% 2>NUL
echo.
echo Done
exit /B 0
