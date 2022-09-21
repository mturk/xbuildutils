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
rem Dowloads CMake
rem
pushd %~dp0
set "_WorkPath=%cd%"
popd
rem Get versions
call iversions.bat
set "CMakeName=cmake-%CMakeVer%-windows-x86_64"
set "CMakeArch=%CMakeName%.zip"
if not exist "%CMakeArch%" (
    curl %CurlOpts% -o %CMakeArch% https://github.com/Kitware/CMake/releases/download/v%CMakeVer%/%CMakeArch%
)
rem
7za t %CMakeArch% >NUL 2>&1 && ( goto Exp )
echo.
echo Failed to download %CMakeArch%
del /F /Q %CMakeArch% 2>NUL
exit /B 1
rem
:Exp
rem
echo CMake  : %CMakeName% >>compile.log
rem Remove previous stuff
rd /S /Q %_UtilsPath%\cmake\%CMakeVer% 2>NUL
md %_UtilsPath%\cmake >NUL 2>&1
pushd %_UtilsPath%\cmake
rem Uncopress
7za x -bd %_WorkPath%\%CMakeArch%
rem
move /Y %CMakeName% %CMakeVer% >NUL
popd
echo.
echo Finished.
:End
exit /B 0
