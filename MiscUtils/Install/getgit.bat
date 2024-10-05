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
rem Download Portable Git
rem
pushd %~dp0
set "_WorkPath=%cd%"
pushd ..\..\
set "PATH=%cd%;%PATH%"
popd
popd
rem Get versions
call %_WorkPath%\iversions.bat
rem
set "GitName=PortableGit-%PortableGitVer%-64-bit"
set "GitArch=%GitName%.7z.exe"
if not exist "%GitArch%" (
    echo.
    echo Downloading %GitArch% ...
    curl %CurlOpts% -o %GitArch% https://github.com/git-for-windows/git/releases/download/v%PortableGitVer%.windows.1/%GitArch%
)
rem
rem
echo [%DATE% %TIME%] PortableGit  : %GitName% >>install.log
rem Remove previous stuff
rd /S /Q %_UtilsPath%\git\%PortableGitVer% 2>NUL
rem
echo Extracting %GitArch% ...
rem
start /B /MIN /WAIT %GitArch% -o "%_UtilsPath%\git\%PortableGitVer%" -y
echo.
echo Finished.
:End
exit /B 0
