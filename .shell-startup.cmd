@echo off
rem alias (with doskey), utf-8, prompt and clink 
chcp 65001 >nul
doskey /macrofile="%userprofile%\.doskey_aliases.txt" 1>nul 2>nul
prompt $e[2;33;33m[$e[2;00;33m$p$e[2;33;33m]$e[2;0;0m$_$g

REM Låt detta stå. Kör det aldrig här då fungerar inte vimgo in vim...
REM call "%USERPROFILE%\Tools\RefreshEnv.cmd" >nul 2>&1

REM Låt detta stå. Kör inte clink är redan igång
REM C:\Program Files (x86)\clink\clink_x64.exe" inject
