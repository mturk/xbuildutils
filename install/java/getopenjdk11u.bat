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
rem Dowload and install Temurin OpenJDK11U jdk
rem
set "JavaVersion=11"
set "JavaRelease=11.0.24"
set "JavaBuild=8"
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
set "JdkName=%JavaRelease%_%JavaBuild%"
set "JdkDirName=jdk-%JavaRelease%+%JavaBuild%"
set "JdkArchive=OpenJDK11U-jdk_x64_windows_hotspot_%JdkName%.zip"
set "UrlBase=https://github.com/adoptium/temurin11-binaries/releases/download/%JdkDirName%"
rem
echo Installing Temurin OpenJDK-%JdkName% ...
rem
if not exist "%JdkArchive%" (
    echo Downloading %JdkArchive% ...
    curl.exe %_CurlOpts% -o %JdkArchive% %UrlBase%/%JdkArchive%
)
rem
7za.exe t %JdkArchive% >NUL 2>&1 || ( goto ErrArch )
rem
:Exp
rem
rem Remove previous stuff
rd /S /Q %_InstallPath%\java\%JavaVersion% 2>NUL
md %_InstallPath%\java\%JavaVersion% >NUL 2>&1
pushd %_InstallPath%\java\%JavaVersion%
rem Uncompress
7za.exe x -bd %_WorkPath%\%JdkArchive%
rem
move /Y %JdkDirName% jdk >NUL
popd
rem
echo.
echo Finished.
:End
exit /B 0
rem
:ErrArch
echo.
echo Failed to download Temurin OpenJDK %JdkName%
del /F /Q %JdkArchive% 2>NUL
exit /B 1
