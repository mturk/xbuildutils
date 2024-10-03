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
rem Dowloads Temurin OpenJDK11U jdk
rem
pushd %~dp0
set "_WorkPath=%cd%"
pushd ..\
set "PATH=%cd%;%PATH%"
popd
popd
rem Set versions
set "_CurlOpts=-qkL --retry 5 --no-progress-meter"
set "_InstallPath=C:\xbuild"
set "Java11Ver=11.0.24"
set "Java11Bld=8"
set "Java11=%Java11Ver%_%Java11Bld%"
set "JdkDirName=jdk-%Java11Ver%+%Java11Bld%"
set "JdkArch=OpenJDK11U-jdk_x64_windows_hotspot_%Java11%.zip"
set "UrlBase=https://github.com/adoptium/temurin11-binaries/releases/download/%JdkDirName%"
rem
echo Installing Temurin OpenJDK-%Java11% ...
rem
if not exist "%JdkArch%" (
    echo Downloading %JdkArch% ...
    curl %_CurlOpts% -o %JdkArch% %UrlBase%/%JdkArch%
)
rem
7za t %JdkArch% >NUL 2>&1 || ( goto ErrArch )
rem
:Exp
rem
rem Remove previous stuff
rd /S /Q %_InstallPath%\java\11 2>NUL
md %_InstallPath%\java >NUL 2>&1
pushd %_InstallPath%\java
rem Uncompress
7za x -bd %_WorkPath%\%JdkArch%
rem
move /Y %JdkDirName% 11 >NUL
popd
rem
echo.
echo Finished.
:End
exit /B 0
rem
:ErrArch
echo.
echo Failed to download Temurin OpenJDK %Java11%
del /F /Q %JdkArch% 2>NUL
exit /B 1
