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
rem Dowloads Strawberry Perl
rem
set "PerlVer=5.40.0.1"
set "PerlBld=SP_54001_64bit_UCRT"
rem set "PerlVer=5.38.2.2"
rem set "PerlBld=SP_53822_64bit"
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
set "PerlName=strawberry-perl-%PerlVer%-64bit-portable"
set "PerlArch=%PerlName%.zip"
if not exist "%PerlArch%" (
    echo.
    echo Downloading %PerlArch% ...
    curl.exe %CurlOpts% -o %PerlArch% https://github.com/StrawberryPerl/Perl-Dist-Strawberry/releases/download/%PerlBld%/%PerlArch%
)
rem
7za.exe t %PerlArch% >NUL 2>&1 && ( goto Exp )
echo.
echo Failed to download %PerlArch%
del /F /Q %PerlArch% 2>NUL
exit /B 1
rem
:Exp
rem
rem Remove previous stuff
rd /S /Q %_XbuildUtilsDir%\perl 2>NUL
md %_XbuildUtilsDir%\perl >NUL 2>&1
pushd %_XbuildUtilsDir%\perl
rem
7za.exe x -bd %_WorkPath%\%PerlArch%
rem rd /S /Q c 2>NUL
rem copy /Y /B perl\bin\perl.exe perl\bin\perlw.exe >NUL
rem
popd
echo.
echo Finished.
:End
exit /B 0
