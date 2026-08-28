@echo off
setlocal

REM ==========================================
REM CONFIGURATION
REM ==========================================

set "PG_BIN=C:\Program Files\PostgreSQL\18\bin"
set "SOURCE_DATABASE=company"
set "TARGET_DATABASE=company_restore_test"
set "DB_USER=postgres"
set "BACKUP_DIR=C:\Backups\PostgreSQL"
set "LOG_FILE=%BACKUP_DIR%\restore.log"

REM ==========================================
REM CREATE LOG DIRECTORY
REM ==========================================

if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

REM ==========================================
REM FIND LATEST BACKUP
REM ==========================================

for /f "delims=" %%F in ('dir /b /o-d "%BACKUP_DIR%\%SOURCE_DATABASE%_*.backup" 2^>nul') do (
    set "BACKUP_FILE=%BACKUP_DIR%\%%F"
    goto backup_found
)

echo ERROR: No backup file found.
echo ERROR: No backup file found. >> "%LOG_FILE%"
exit /b 1

:backup_found

REM ==========================================
REM START RESTORE
REM ==========================================

echo ========================================== >> "%LOG_FILE%"
echo Restore started: %date% %time% >> "%LOG_FILE%"
echo Source database: %SOURCE_DATABASE% >> "%LOG_FILE%"
echo Target database: %TARGET_DATABASE% >> "%LOG_FILE%"
echo Backup file: %BACKUP_FILE% >> "%LOG_FILE%"

echo Backup selected:
echo %BACKUP_FILE%

REM ==========================================
REM CHECK TARGET DATABASE
REM ==========================================

"%PG_BIN%\psql.exe" -U "%DB_USER%" -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='%TARGET_DATABASE%';" > "%TEMP%\db_check.txt" 2>&1

set /p DB_EXISTS=<"%TEMP%\db_check.txt"

if "%DB_EXISTS%"=="1" (
    echo ERROR: Target database already exists.
    echo ERROR: Target database already exists. >> "%LOG_FILE%"
    exit /b 1
) else (
    echo Creating target database...
    echo Creating target database... >> "%LOG_FILE%"

	"%PG_BIN%\psql.exe" -U "%DB_USER%" -d postgres -c "CREATE DATABASE %TARGET_DATABASE%;" >> "%LOG_FILE%" 2>&1

	if errorlevel 1 (
    		echo ERROR: Could not create target database.
   		echo ERROR: Could not create target database. >> "%LOG_FILE%"
    		exit /b 1
   	)
)

REM ==========================================
REM RESTORE DATABASE
REM ==========================================

echo Starting pg_restore...
echo Starting pg_restore... >> "%LOG_FILE%"

"%PG_BIN%\pg_restore.exe" -U "%DB_USER%" -d "%TARGET_DATABASE%" "%BACKUP_FILE%" >> "%LOG_FILE%" 2>&1

REM ==========================================
REM VERIFY RESULT
REM ==========================================

if %ERRORLEVEL% EQU 0 (
    echo Restore completed successfully.
    echo Restore completed successfully. >> "%LOG_FILE%"
) else (
    echo ERROR: Restore failed.
    echo ERROR: Restore failed. >> "%LOG_FILE%"
)

echo Restore finished: %date% %time% >> "%LOG_FILE%"
echo ========================================== >> "%LOG_FILE%"

del "%TEMP%\db_check.txt" >nul 2>&1

endlocal