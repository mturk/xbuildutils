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
set "_UtilsPath=C:\xbuildutils"
pushd %~dp0
set "_WorkPath=%cd%"
popd
rem
set "NasmName=nasm-%NasmVer%-win64"
set "NasmArch=%NasmName%.zip"
if not exist "%NasmArch%" (
    echo.
    echo Downloading %NasmArch% ...
    curl %CurlOpts% -o %NasmArch% https://www.nasm.us/pub/nasm/releasebuilds/%NasmVer%/win64/%NasmArch%
)
rem
7za t %NasmArch% >NUL 2>&1 && ( goto Exp )
echo.
echo Failed to download %NasmArch%
del /F /Q %NasmArch% 2>NUL
exit /B 1
rem
:Exp
rem
rem Remove previous stuff
rd /S /Q %_UtilsPath%\nasm 2>NUL
md %_UtilsPath% >NUL 2>&1
pushd %_UtilsPath%
rem
7za x -bd %_WorkPath%\%NasmArch%
rem
move /Y nasm-%NasmVer% nasm >NUL
popd
echo.
echo Finished.
:End
exit /B 0
