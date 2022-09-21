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
pushd %~dp0
set "_WorkPath=%cd%"
popd
rem Get versions
call iversions.bat
set "PerlName=strawberry-perl-%PerlVer%-64bit-portable"
set "PerlArch=%PerlName%.zip"
if not exist "%PerlArch%" (
    echo.
    echo Downloading %PerlArch% ... this can take a while.
    curl %CurlOpts% -o %PerlArch% http://strawberryperl.com/download/%PerlVer%/%PerlArch%
)
rem
7za t %PerlArch% >NUL 2>&1 && ( goto Exp )
echo.
echo Failed to download %PerlArch%
del /F /Q %PerlArch% 2>NUL
exit /B 1
rem
:Exp
rem
echo Perl   : %PerlName% >>compile.log
rem Remove previous stuff
rd /S /Q %_UtilsPath%\perl\%PerlVer% 2>NUL
md %_UtilsPath%\perl\%PerlVer% >NUL 2>&1
rem Uncopress
pushd %_UtilsPath%\perl\%PerlVer%
7za x -bd %_WorkPath%\%PerlArch%
copy /Y /B perl\bin\perl.exe perl\bin\perlw.exe >NUL
rem
popd
echo.
echo Finished.
:End
exit /B 0
