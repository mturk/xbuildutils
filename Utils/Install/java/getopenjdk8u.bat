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
rem Dowloads Temurin OpenJDK8U jdk
rem
pushd %~dp0
set "_WorkPath=%cd%"
pushd ..\..\
set "PATH=%cd%;%PATH%"
popd
popd
rem Get versions
call %_WorkPath%\iversions.bat
set "Java8=8u%Java8Ver%%Java8Bld%"
set "Java8Dir=8.0_%Java8Ver%_%Java8Bld%"
set "JdkDirName=jdk8u%Java8Ver%-%Java8Bld%"
set "JdkArch=OpenJDK8U-jdk_x64_windows_hotspot_%Java8%.zip"
set "UrlBase=https://github.com/adoptium/temurin8-binaries/releases/download/%JdkDirName%"
rem
echo Installing Temurin OpenJDK8U-%Java8% ...
rem
if not exist "%JdkArch%" (
    echo Downloading %JdkArch% ...
    curl %CurlOpts% -o %JdkArch% %UrlBase%/%JdkArch%
)
rem
7za t %JdkArch% >NUL 2>&1 && ( goto Exp )
echo.
echo Failed to download Temurin OpenJDK %Java8%
del /F /Q %JdkArch% 2>NUL
exit /B 1
rem
:Exp
rem
echo [%DATE% %TIME%] Java   : Temurin OpenJDK %Java8% >>install.log
md %_ToolsPath%\java >NUL 2>&1
rem Remove previous stuff
rd /S /Q %_ToolsPath%\java\%Java8Dir% 2>NUL
pushd %_ToolsPath%\java
rem Uncompress
7za x -bd %_WorkPath%\%JdkArch%
rem
move /Y %JdkDirName% %Java8Dir% >NUL
popd
echo rem Set Temurin OpenJDK 8 Environment Variables >>install.log
echo rem set "JDK_8_HOME=%%_ToolsPath%%\java\%Java8Dir%" >>install.log
echo rem set "JRE_8_HOME=%%_ToolsPath%%\java\%Java8Dir%\jre" >>install.log
echo.
echo Finished.
:End
exit /B 0
