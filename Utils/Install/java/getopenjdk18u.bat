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
rem Dowloads Temurin OpenJDK18U jdk and jre
rem
pushd %~dp0
set "_WorkPath=%cd%"
pushd ..\..\
set "PATH=%cd%;%PATH%"
popd
popd
rem Get versions
call %_WorkPath%\iversions.bat
set "Java18=%Java18Ver%_%Java18Bld%"
set "JdkDirName=jdk-%Java18Ver%+%Java18Bld%"
set "JreDirName=%JdkDirName%-jre"
set "JdkArch=OpenJDK18U-jdk_x64_windows_hotspot_%Java18%.zip"
set "JreArch=OpenJDK18U-jre_x64_windows_hotspot_%Java18%.zip"
set "UrlBase=https://github.com/adoptium/temurin18-binaries/releases/download/%JdkDirName%"
rem
echo Installing Temurin OpenJDK-%Java18% ...
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
echo Java   : Temurin OpenJDK %Java18% >>install.log
rem Remove previous stuff
rd /S /Q %_ToolsPath%\java\%Java18% 2>NUL
md %_ToolsPath%\java\%Java18% >NUL 2>&1
pushd %_ToolsPath%\java\%Java18%
rem Uncompress
7za x -bd %_WorkPath%\%JdkArch%
7za x -bd %_WorkPath%\%JreArch%
rem
move /Y %JdkDirName% jdk >NUL
move /Y %JreDirName% jre >NUL
popd
echo rem Set Temurin OpenJDK 18 Environment Variables >>install.log
echo rem set "JDK_18_HOME=%%_ToolsPath%%\java\%Java18%\jdk" >>install.log
echo rem set "JRE_18_HOME=%%_ToolsPath%%\java\%Java18%\jre" >>install.log
echo.
echo Finished.
:End
exit /B 0
rem
:ErrArch
echo.
echo Failed to download Temurin OpenJDK %Java18%
del /F /Q %JdkArch% 2>NUL
del /F /Q %JreArch% 2>NUL
exit /B 1
