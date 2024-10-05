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
rem Dowloads Temurin OpenJDK21U jdk and jre
rem
pushd %~dp0
set "_WorkPath=%cd%"
pushd ..\..\
set "PATH=%cd%;%PATH%"
popd
popd
rem Get versions
call %_WorkPath%\iversions.bat
set "Java21=%Java21Ver%_%Java21Bld%"
set "JdkDirName=jdk-%Java21Ver%+%Java21Bld%"
set "JreDirName=%JdkDirName%-jre"
set "JdkArch=OpenJDK21U-jdk_x64_windows_hotspot_%Java21%.zip"
set "JreArch=OpenJDK21U-jre_x64_windows_hotspot_%Java21%.zip"
set "UrlBase=https://github.com/adoptium/temurin21-binaries/releases/download/%JdkDirName%"
rem
echo Installing Temurin OpenJDK-%Java21% ...
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
echo. >>%_InstallFile%
echo rem [%DATE% %TIME%] Java   : Temurin OpenJDK %Java21% >>%_InstallFile%
echo rem >>%_InstallFile%
rem Remove previous stuff
rd /S /Q %_InstallPath%\java\%Java21% 2>NUL
md %_InstallPath%\java\%Java21% >NUL 2>&1
pushd %_InstallPath%\java\%Java21%
rem Uncompress
7za x -bd %_WorkPath%\%JdkArch%
7za x -bd %_WorkPath%\%JreArch%
rem
move /Y %JdkDirName% jdk >NUL
move /Y %JreDirName% jre >NUL
popd
echo rem Set Temurin OpenJDK 21 Environment Variables >>%_InstallFile%
echo rem set "JDK_21_HOME=%_InstallPath%\java\%Java21%\jdk" >>%_InstallFile%
echo rem set "JRE_21_HOME=%_InstallPath%\java\%Java21%\jre" >>%_InstallFile%
echo. >>%_InstallFile%
echo rem Set Temurin OpenJDK 21 System Environment Variables >>%_InstallFile%
echo setx JDK_21_HOME %_InstallPath%\java\%Java21%\jdk /M >>%_InstallFile%
echo setx JRE_21_HOME %_InstallPath%\java\%Java21%\jre /M >>%_InstallFile%
echo rem >>%_InstallFile%
echo rem setx JAVA_HOME %%%%JDK_21_HOME%%%% /M >>%_InstallFile%
echo rem setx JRE_HOME %%%%JRE_21_HOME%%%% /M >>%_InstallFile%
echo. >>%_InstallFile%
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
del /F /Q %JreArch% 2>NUL
exit /B 1
