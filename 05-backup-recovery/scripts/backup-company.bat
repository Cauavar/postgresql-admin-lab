@echo off
setlocal

REM ==========================================
REM CONFIGURATION
REM ==========================================

set "PG_BIN=C:\Program Files\PostgreSQL\18\bin"
set "DATABASE=company"
set "DB_USER=postgres"
set "BACKUP_DIR=C:\Backups\PostgreSQL"
set "LOG_FILE=%BACKUP_DIR%\backup.log"

REM ==========================================
REM CREATE BACKUP DIRECTORY
REM ==========================================

if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

REM ==========================================
REM GET DATE AND TIME
REM ==========================================

for /f "tokens=1-3 delims=/" %%a in ("%date%") do (
    set "DAY=%%a"
    set "MONTH=%%b"
    set "YEAR=%%c"
)

for /f "tokens=1-2 delims=:." %%a in ("%time%") do (
    set "HOUR=%%a"
    set "MINUTE=%%b"
)

set "HOUR=%HOUR: =0%"

set "BACKUP_FILE=%BACKUP_DIR%\%DATABASE%_%YEAR%-%MONTH%-%DAY%_%HOUR%-%MINUTE%.backup"

REM ==========================================
REM START BACKUP
REM ==========================================

echo ========================================== >> "%LOG_FILE%"
echo Backup started: %date% %time% >> "%LOG_FILE%"
echo Database: %DATABASE% >> "%LOG_FILE%"
echo Backup file: %BACKUP_FILE% >> "%LOG_FILE%"

"%PG_BIN%\pg_dump.exe" -U "%DB_USER%" -d "%DATABASE%" -F c -f "%BACKUP_FILE%" >> "%LOG_FILE%" 2>&1

REM ==========================================
REM VERIFY RESULT
REM ==========================================

if %ERRORLEVEL% EQU 0 (
    echo Backup completed successfully. >> "%LOG_FILE%"
    echo Backup completed successfully.
) else (
    echo ERROR: Backup failed. >> "%LOG_FILE%"
    echo ERROR: Backup failed.
)

echo Backup finished: %date% %time% >> "%LOG_FILE%"
echo ========================================== >> "%LOG_FILE%"

endlocal