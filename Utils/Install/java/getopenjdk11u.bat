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
rem Dowloads Temurin OpenJDK11U jdk and jre
rem
pushd %~dp0
set "_WorkPath=%cd%"
pushd ..\..\
set "PATH=%cd%;%PATH%"
popd
popd
rem Get versions
call %_WorkPath%\iversions.bat
set "Java11=%Java11Ver%_%Java11Bld%"
set "JdkDirName=jdk-%Java11Ver%+%Java11Bld%"
set "JreDirName=%JdkDirName%-jre"
set "JdkArch=OpenJDK11U-jdk_x64_windows_hotspot_%Java11%.zip"
set "JreArch=OpenJDK11U-jre_x64_windows_hotspot_%Java11%.zip"
set "UrlBase=https://github.com/adoptium/temurin11-binaries/releases/download/%JdkDirName%"
rem
echo Installing Temurin OpenJDK-%Java11% ...
rem
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
:Exp
rem
echo. >>%_InstallFile%
echo rem [%DATE% %TIME%] Java   : Temurin OpenJDK %Java11% >>%_InstallFile%
echo rem >>%_InstallFile%
rem Remove previous stuff
rd /S /Q %_InstallPath%\java\%Java11% 2>NUL
md %_InstallPath%\java\%Java11% >NUL 2>&1
pushd %_InstallPath%\java\%Java11%
rem Uncompress
7za x -bd %_WorkPath%\%JdkArch%
7za x -bd %_WorkPath%\%JreArch%
rem
move /Y %JdkDirName% jdk >NUL
move /Y %JreDirName% jre  >NUL
popd
echo rem Set Temurin OpenJDK 11 Environment Variables >>%_InstallFile%
echo rem set "JDK_11_HOME=%_InstallPath%\java\%Java11%\jdk" >>%_InstallFile%
echo rem set "JRE_11_HOME=%_InstallPath%\java\%Java11%\jre" >>%_InstallFile%
echo. >>%_InstallFile%
echo rem Set Temurin OpenJDK 11 System Environment Variables >>%_InstallFile%
echo setx JDK_11_HOME %_InstallPath%\java\%Java11%\jdk /M >>%_InstallFile%
echo setx JRE_11_HOME %_InstallPath%\java\%Java11%\jre /M >>%_InstallFile%
echo rem >>%_InstallFile%
echo rem setx JAVA_HOME %%%%JDK_11_HOME%%%% /M >>%_InstallFile%
echo rem setx JRE_HOME %%%%JRE_11_HOME%%%% /M >>%_InstallFile%
echo. >>%_InstallFile%

echo.
echo Finished.
:End
exit /B 0
rem
:ErrArch
echo.
echo Failed to download Temurin OpenJDK %Java11%
del /F /Q %JdkArch% 2>NUL
del /F /Q %JreArch% 2>NUL
exit /B 1
