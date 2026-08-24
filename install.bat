@echo off
setlocal EnableExtensions

rem self-learning-review global install/update script (Windows, double-click to run)
rem NOTE: keep this file ASCII-only. cmd.exe parses batch files in the system
rem ANSI codepage, so non-ASCII text breaks parsing (chcp does not fix this).
rem Source = this script's folder; Target = %USERPROFILE%\.claude\skills\...

set "SRC=%~dp0"
if "%SRC:~-1%"=="\" set "SRC=%SRC:~0,-1%"
set "DST=%USERPROFILE%\.claude\skills\self-learning-review"
set "ACTION=INSTALL"

if not exist "%SRC%\SKILL.md" (
    echo [ERROR] SKILL.md not found in script folder. Run from the repo root.
    goto :fail
)

if exist "%DST%\SKILL.md" set "ACTION=UPDATE"

echo [INFO] Source : %SRC%
echo [INFO] Target : %DST%
echo [INFO] Action : %ACTION% ^(SKILL.md + templates + examples + references^)

mkdir "%DST%" 2>nul

robocopy "%SRC%" "%DST%" SKILL.md /NJH /NJS /NDL /NP /NFL
if errorlevel 8 goto :copyfail

for %%D in (templates examples references) do (
    if exist "%SRC%\%%D\" (
        robocopy "%SRC%\%%D" "%DST%\%%D" /MIR /NJH /NJS /NDL /NP /NFL
        if errorlevel 8 goto :copyfail
    )
)

if not exist "%DST%\SKILL.md" goto :copyfail

echo.
echo [DONE] self-learning-review %ACTION% complete. Installed to:
echo        %DST%
echo.
echo Next: open a NEW Claude Code session and type /self-learning-review to verify.
echo.
goto :end

:copyfail
echo [ERROR] Copy failed. Check permissions on the target folder.

:fail
if not defined SLR_NO_PAUSE pause
endlocal
exit /b 1

:end
if not defined SLR_NO_PAUSE pause
endlocal
exit /b 0
