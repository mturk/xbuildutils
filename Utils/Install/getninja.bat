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
rem Download Ninja
rem
pushd %~dp0
set "_WorkPath=%cd%"
popd
rem Get versions
call iversions.bat
set "NinjaName=ninja-%NinjaVer%-win"
set "NinjaArch=%NinjaName%.zip"
if not exist "%NinjaArch%" (
    curl %CurlOpts% -o %NinjaArch% https://github.com/ninja-build/ninja/releases/download/v%NinjaVer%/ninja-win.zip	
)
rem
7za t %NinjaArch% >NUL 2>&1 && ( goto Exp )
echo.
echo Failed to download %NinjaArch%
del /F /Q %NinjaArch% 2>NUL
exit /B 1
rem
:Exp
rem
echo Ninja  : %NinjaName% >>compile.log
rem Remove previous stuff
rd /S /Q %_UtilsPath%\ninja\%NinjaVer% 2>NUL
md %_UtilsPath%\ninja\%NinjaVer% >NUL 2>&1
rem Uncopress
pushd %_UtilsPath%\ninja\%NinjaVer%
7za x -y -bd %_WorkPath%\%NinjaArch%
rem
popd
echo.
echo Finished.
:End
exit /B 0
