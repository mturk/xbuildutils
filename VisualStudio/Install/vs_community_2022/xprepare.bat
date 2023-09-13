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
rem Create offline Installer for Visual Studio 2022 Community
rem
rem
pushd %~dp0
set "_WORKDIR=%cd%"
popd
rem
set "_VSPRODUCTVER=2022"
set "_VSPRODUCTBLD=17.7.4"
set "_VSINSTALLDIR=vs2022c"
set "_VSINSTALLPKG=Packages"
set "_VSINSTALLTMP=Temp"
set "_MSCINSTALLER=vs_community.exe"
set "_VSINSTALLOUT=vs_community_%_VSPRODUCTVER%_%_VSPRODUCTBLD%"
set "_VSLAYOUTBASE=C:\VisualStudio\Layouts"
set "_VSLAYOUTDIST=%_VSLAYOUTBASE%\%_VSINSTALLDIR%"
rem
echo.
echo Creating Visual Studio %_VSPRODUCTVER% %_VSPRODUCTBLD% Community offline distribution
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
rem Download bootstraper
rem
curl -qkL --retry 5 --no-progress-meter -o %_MSCINSTALLER% ^
https://aka.ms/vs/17/release/vs_community.exe
if not exist "%_MSCINSTALLER%" (
  echo Missing %_MSCINSTALLER%
  exit /B 1
)
rem
start /wait %_MSCINSTALLER% --layout "%_VSLAYOUTDIST%\%_VSINSTALLPKG%" ^
--add Microsoft.VisualStudio.Workload.NativeDesktop;includeRecommended ^
--locale en-US ^
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
rem copy /Y xresponse.json %_VSLAYOUTDIST%\%_VSINSTALLPKG%\Response.json >NUL
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
echo Creating Visual Studio %_VSINSTALLOUT% Community offline tar archive
echo This can take a while ...
rem Use Windows BSD tar
%SystemRoot%\System32\tar.exe -cf %_VSLAYOUTBASE%\%_VSINSTALLOUT%.tar %_VSLAYOUTDIST%
rem
:End
echo.
echo Done
exit /B 0
