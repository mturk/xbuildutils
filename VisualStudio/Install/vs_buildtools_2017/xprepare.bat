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
rem Create offline Installer for Visual Studio 2017 Build Tools
rem
rem
pushd %~dp0
set "_WORKDIR=%cd%"
popd
rem
set "_VSPRODUCTVER=2017"
set "_VSPRODUCTBLD=15.9.55"
set "_VSINSTALLDIR=vs2017b"
set "_VSINSTALLPKG=Packages"
set "_VSINSTALLTMP=Temp"
set "_MSCINSTALLER=vs_buildtools.exe"
set "_VSINSTALLOUT=vs_buildtools_%_VSPRODUCTVER%_%_VSPRODUCTBLD%"
set "_VSLAYOUTBASE=C:\VisualStudio\Layouts"
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
rem https://community.chocolatey.org/packages/visualstudio2017buildtools#files
rem check tools\ChocolateyInstall.ps1
rem
curl -qkL --retry 5 --no-progress-meter -o %_MSCINSTALLER% ^
https://download.visualstudio.microsoft.com/download/pr/f201226a-54ad-4c5b-b665-49d12a86a848/03bdefeed0104ed777cd87d0ed3885f8561954020071110cfe93420c117caa23/vs_BuildTools.exe
if not exist "%_MSCINSTALLER%" (
  echo Missing %_MSCINSTALLER%
  exit /B 1
)
rem
start /wait %_MSCINSTALLER% --layout "%_VSLAYOUTDIST%\%_VSINSTALLPKG%" ^
--add Microsoft.VisualStudio.Workload.VCTools;includeRecommended ^
--locale en-US --useLatestInstaller ^
--quiet --norestart --wait >NUL
rem
if "%ERRORLEVEL%" NEQ "0" (
  echo %_MSCINSTALLER% failed with error %ERRORLEVEL%
  exit /B 1
)
rem
popd
for %%i in (README.txt xinstall.bat xvcvars.bat xvcvars.sh) do (
  copy /Y %%i %_VSLAYOUTDIST%\ >NUL
)
copy /Y xresponse.json %_VSLAYOUTDIST%\%_VSINSTALLPKG%\Response.json >NUL
copy /Y xlayout.json %_VSLAYOUTDIST%\%_VSINSTALLPKG%\Layout.json >NUL
rem
if /i "x%~1" EQU "x/u" goto End
rem
echo Downloading latest CRT Redistributables
curl -qkL --retry 5 --no-progress-meter -o %_VSLAYOUTDIST%\vc_redist.x64.exe https://aka.ms/vs/17/release/vc_redist.x64.exe
curl -qkL --retry 5 --no-progress-meter -o %_VSLAYOUTDIST%\vc_redist.x86.exe https://aka.ms/vs/17/release/vc_redist.x86.exe
rem
if /i "x%~1" NEQ "x/d" goto End
rem
rem ping -n 6 localhost >NUL 2>&1
echo.
echo Creating Visual Studio %_VSINSTALLOUT% Build Tools offline tar archive
echo This can take a while ...
rem Use Windows BSD tar
%SystemRoot%\System32\tar.exe -cf %_VSLAYOUTBASE%\%_VSINSTALLOUT%.tar %_VSLAYOUTDIST%
rem
:End
echo.
echo Done
exit /B 0
