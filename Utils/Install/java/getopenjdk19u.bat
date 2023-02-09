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
rem Dowloads Temurin OpenJDK19U jdk and jre
rem
pushd %~dp0
set "_WorkPath=%cd%"
pushd ..\..\
set "PATH=%cd%;%PATH%"
popd
popd
rem Get versions
call %_WorkPath%\iversions.bat
set "Java19=%Java19Ver%_%Java19Bld%"
set "JdkDirName=jdk-%Java19Ver%+%Java19Bld%"
set "JreDirName=%JdkDirName%-jre"
set "JdkArch=OpenJDK19U-jdk_x64_windows_hotspot_%Java19%.zip"
set "JreArch=OpenJDK19U-jre_x64_windows_hotspot_%Java19%.zip"
set "UrlBase=https://github.com/adoptium/temurin19-binaries/releases/download/%JdkDirName%"
rem
echo Installing Temurin OpenJDK-%Java19% ...
if not exist "%JdkArch%" (
    echo Downloading %JdkArch% ...
    curl %CurlOpts% -o %JdkArch% %UrlBase%/%JdkArch%
)
if not exist "%JreArch%" (
    echo Downloading %JreArch% ...
    curl %CurlOpts% -o %JreArch% %UrlBase%/%JreArch%
)
rem
7za t %JdkArch% >NUL 2>&1 || ( goto ErrArch )
7za t %JreArch% >NUL 2>&1 || ( goto ErrArch )
rem
echo [%DATE% %TIME%] Java   : Temurin OpenJDK %Java19% >>install.log
rem Remove previous stuff
rd /S /Q %_ToolsPath%\java\%Java19% 2>NUL
md %_ToolsPath%\java\%Java19% >NUL 2>&1
pushd %_ToolsPath%\java\%Java19%
rem Uncompress
7za x -bd %_WorkPath%\%JdkArch%
7za x -bd %_WorkPath%\%JreArch%
rem
move /Y %JdkDirName% jdk >NUL
move /Y %JreDirName% jre >NUL
popd
echo rem Set Temurin OpenJDK 19 Environment Variables >>install.log
echo rem set "JDK_19_HOME=%%_ToolsPath%%\java\%Java19%\jdk" >>install.log
echo rem set "JRE_19_HOME=%%_ToolsPath%%\java\%Java19%\jre" >>install.log
echo.
echo Finished.
:End
exit /B 0
rem
:ErrArch
echo.
echo Failed to download Temurin OpenJDK %Java19%
del /F /Q %JdkArch% 2>NUL
del /F /Q %JreArch% 2>NUL
exit /B 1
