@echo off
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
rem
if "x%_UDD%" NEQ "x" goto :Error
rem
pushd %~dp0
set "_UDD=%cd%"
popd
rem Load versions
call uversions.bat
rem
set "_GITSW=%_UDD%\git\%_GITSW_VER%\cmd"
set "_SVNSW=%_UDD%\svn\%_SVNSW_VER%\bin"
set "_CYGWR=%_UDD%\cygwrun\%_CYGWR_VER%"
rem Add git and svn to PATH
set "_ADDSW=%_GITSW%;%_SVNSW%;%_CYGWR%"
if "x%~1" NEQ "x/a" goto :End
rem
rem Add other tools to PATH if called with /a parameter
rem
set "_CMAKE=%_UDD%\cmake\%_CMAKE_VER%\bin"
set "_NINJA=%_UDD%\ninja\%_NINJA_VER%"
set "_NASMW=%_UDD%\nasm\%_NASMW_VER%"
set "_PERLW=%_UDD%\perl\%_PERLW_VER%\perl\bin"
set "_CCLAM=%_UDD%\clamav\%_CCLAM_VER%"
rem
set "_ADDSW=%_ADDSW%;%_CMAKE%;%_NINJA%;%_NASMW%;%_PERLW%;%_CCLAM%"
rem
:End
set "PATH=%_ADDSW%;%PATH%"
rem Clean local variables
set _ADDSW=
set _GITSW=
set _SVNSW=
set _CYGWR=
rem
set _CMAKE=
set _NINJA=
set _NASMW=
set _PERLW=
set _CCLAM=
rem
set _GITSW_VER=
set _SVNSW_VER=
set _PERLW_VER=
set _NASMW_VER=
set _CMAKE_VER=
set _NINJA_VER=
set _CCLAM_VER=
rem
exit /B 0
rem
:Error
echo Error:  %~nx0 already called
exit /B 1
