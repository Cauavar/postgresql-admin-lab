@echo off
setlocal

REM ==========================================
REM CONFIGURATION
REM ==========================================

set "BACKUP_SCRIPT=%~dp0..\..\05-backup-recovery\scripts\backup-company.bat"
set "VACUUM_SCRIPT=%~dp0..\..\06-maintenance\scripts\vacuum-analyze-company.bat"

REM ==========================================
REM START AUTOMATION
REM ==========================================

echo ==========================================
echo PostgreSQL Daily Maintenance
echo Started: %date% %time%
echo ==========================================

REM ==========================================
REM RUN BACKUP
REM ==========================================

echo.
echo [1/2] Starting database backup...

call "%BACKUP_SCRIPT%"

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Backup failed.
    echo Automation stopped.
    exit /b 1
)

echo Backup completed successfully.

REM ==========================================
REM RUN VACUUM ANALYZE
REM ==========================================

echo.
echo [2/2] Starting VACUUM ANALYZE...

call "%VACUUM_SCRIPT%"

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: VACUUM ANALYZE failed.
    exit /b 1
)

echo VACUUM ANALYZE completed successfully.

REM ==========================================
REM FINISH
REM ==========================================

echo.
echo ==========================================
echo Daily maintenance completed successfully.
echo Finished: %date% %time%
echo ==========================================

endlocal
exit /b 0