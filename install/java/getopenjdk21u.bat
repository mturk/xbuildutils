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
rem Dowloads Temurin OpenJDK21U jdk
rem
pushd %~dp0
set "_WorkPath=%cd%"
pushd ..\
set "PATH=%cd%;%PATH%"
popd
popd
rem Set versions
set "_CurlOpts=-qkL --retry 5 --no-progress-meter"
set "_InstallPath=C:\xbuildutils"
set "Java21Ver=21.0.4"
set "Java21Bld=7"
set "Java21=%Java21Ver%_%Java21Bld%"
set "JdkDirName=jdk-%Java21Ver%+%Java21Bld%"
set "JdkArch=OpenJDK21U-jdk_x64_windows_hotspot_%Java21%.zip"
set "UrlBase=https://github.com/adoptium/temurin21-binaries/releases/download/%JdkDirName%"
rem
echo Installing Temurin OpenJDK-%Java21% ...
if not exist "%JdkArch%" (
    echo Downloading %JdkArch% ...
    curl %_CurlOpts% -o %JdkArch% %UrlBase%/%JdkArch%
)
rem
7za t %JdkArch% >NUL 2>&1 || ( goto ErrArch )
rem
rem Remove previous stuff
rd /S /Q %_InstallPath%\java\21 2>NUL
md %_InstallPath%\java >NUL 2>&1
pushd %_InstallPath%\java
rem Uncompress
7za x -bd %_WorkPath%\%JdkArch%
rem
move /Y %JdkDirName% 21 >NUL
popd
rem
echo.
echo Finished.
:End
exit /B 0
rem
:ErrArch
echo.
echo Failed to download Temurin OpenJDK %Java21%
del /F /Q %JdkArch% 2>NUL
exit /B 1
