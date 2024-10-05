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
rem Dowload Netwide assembler
rem
set "NasmVer=2.16.03"
rem
set "CurlOpts=-qkL --retry 5 --no-progress-meter"
set "_XbuildUtilsDir=C:\xbuildutils"
pushd %~dp0
set "_WorkPath=%cd%"
pushd ..\utils
set "PATH=%cd%;%PATH%"
popd
popd
rem
set "NasmName=nasm-%NasmVer%-win64"
set "NasmArch=%NasmName%.zip"
if not exist "%NasmArch%" (
    echo.
    echo Downloading %NasmArch% ...
    curl.exe %CurlOpts% -o %NasmArch% https://www.nasm.us/pub/nasm/releasebuilds/%NasmVer%/win64/%NasmArch%
)
rem
7za.exe t %NasmArch% >NUL 2>&1 && ( goto Exp )
echo.
echo Failed to download %NasmArch%
del /F /Q %NasmArch% 2>NUL
exit /B 1
rem
:Exp
rem
rem Remove previous stuff
rd /S /Q %_XbuildUtilsDir%\nasm 2>NUL
md %_XbuildUtilsDir% >NUL 2>&1
pushd %_XbuildUtilsDir%
rem
7za.exe x -bd %_WorkPath%\%NasmArch%
rem
move /Y nasm-%NasmVer% nasm >NUL
popd
echo.
echo Finished.
:End
exit /B 0
