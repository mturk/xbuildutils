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
rem Dowloads Temurin OpenJDK20U jdk and jre
rem
pushd %~dp0
set "_WorkPath=%cd%"
pushd ..\..\
set "PATH=%cd%;%PATH%"
popd
popd
rem Get versions
call %_WorkPath%\iversions.bat
set "Java20=%Java20Ver%_%Java20Bld%"
set "JdkDirName=jdk-%Java20Ver%+%Java20Bld%"
set "JreDirName=%JdkDirName%-jre"
set "JdkArch=OpenJDK20U-jdk_x64_windows_hotspot_%Java20%.zip"
set "JreArch=OpenJDK20U-jre_x64_windows_hotspot_%Java20%.zip"
set "UrlBase=https://github.com/adoptium/temurin20-binaries/releases/download/%JdkDirName%"
rem
echo Installing Temurin OpenJDK-%Java20% ...
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
echo [%DATE% %TIME%] Java   : Temurin OpenJDK %Java20% >>install.log
rem Remove previous stuff
rd /S /Q %_ToolsPath%\java\%Java20% 2>NUL
md %_ToolsPath%\java\%Java20% >NUL 2>&1
pushd %_ToolsPath%\java\%Java20%
rem Uncompress
7za x -bd %_WorkPath%\%JdkArch%
7za x -bd %_WorkPath%\%JreArch%
rem
move /Y %JdkDirName% jdk >NUL
move /Y %JreDirName% jre >NUL
popd
echo rem Set Temurin OpenJDK 20 Environment Variables >>install.log
echo rem set "JDK_20_HOME=%%_ToolsPath%%\java\%Java20%\jdk" >>install.log
echo rem set "JRE_20_HOME=%%_ToolsPath%%\java\%Java20%\jre" >>install.log
echo. >>install.log
echo rem Set Temurin OpenJDK 20 System Environment Variables >>install.log
echo rem set "_ToolsPath=%_ToolsPath%" >>install.log
echo rem setx JDK_20_HOME %%_ToolsPath%%\java\%Java20%\jdk /M >>install.log
echo rem setx JRE_20_HOME %%_ToolsPath%%\java\%Java20%\jre /M >>install.log
echo rem setx JAVA_HOME ^^%%JDK_20_HOME^^%% /M >>install.log
echo rem setx JRE_HOME ^^%%JRE_20_HOME^^%% /M >>install.log
rem
echo.
echo Finished.
:End
exit /B 0
rem
:ErrArch
echo.
echo Failed to download Temurin OpenJDK %Java20%
del /F /Q %JdkArch% 2>NUL
del /F /Q %JreArch% 2>NUL
exit /B 1
