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
rem Dowload and install Temurin OpenJDK8U jdk and jre
rem
set "JavaVersion=08"
set "JavaRelease=422"
set "JavaBuild=b05"
rem
pushd %~dp0
set "_WorkPath=%cd%"
pushd ..\..\utils
set "PATH=%cd%;%PATH%"
popd
popd
rem Set versions
set "_CurlOpts=-qkL --retry 5 --no-progress-meter"
set "_InstallPath=C:\xbuildutils"
rem
set "JdkName=8u%JavaRelease%%JavaBuild%"
set "JdkDirName=jdk8u%JavaRelease%-%JavaBuild%"
set "JdkArchive=OpenJDK8U-jdk_x64_windows_hotspot_%JdkName%.zip"
set "UrlBase=https://github.com/adoptium/temurin8-binaries/releases/download/%JdkDirName%"
rem
echo Installing Temurin OpenJDK8U-%JdkName% ...
rem
if not exist "%JdkArchive%" (
    echo Downloading %JdkArchive% ...
    curl.exe %_CurlOpts% -o %JdkArchive% %UrlBase%/%JdkArchive%
)
rem
7za.exe t %JdkArchive% >NUL 2>&1 && ( goto Exp )
echo.
echo Failed to download Temurin OpenJDK %JdkName%
del /F /Q %JdkArchive% 2>NUL
exit /B 1
rem
:Exp
rem
rem Remove previous stuff
rd /S /Q %_InstallPath%\java\%JavaVersion% 2>NUL
md %_InstallPath%\java >NUL 2>&1
pushd %_InstallPath%\java
rem Uncompress
7za.exe x -bd %_WorkPath%\%JdkArchive%
rem
move /Y %JdkDirName% %JavaVersion% >NUL
popd
echo.
echo Finished.
:End
exit /B 0
