@echo off
setlocal enableextensions
set TERM=
rem
rem Chere support for Total Commander
rem Command: %COMSPEC%
rem Parameters: /k "C:\cygwin64\cygwhere.bat "%P""
set "_CYGWDIR=%~1"
rem
rem Add the following to ~/.bashrc
rem if [ ".${_CYGWDIR}" != "." ]; then
rem   cd "${_CYGWDIR}"
rem fi
rem unset _CYGWDIR
rem
cd /d "%~dp0bin" && .\bash --login -i
