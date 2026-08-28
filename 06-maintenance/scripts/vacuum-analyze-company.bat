@echo off
setlocal

REM ==========================================
REM CONFIGURATION
REM ==========================================

set "PG_BIN=C:\Program Files\PostgreSQL\18\bin"
set "DATABASE=company"
set "DB_USER=postgres"
set "LOG_DIR=C:\Backups\PostgreSQL"
set "LOG_FILE=%LOG_DIR%\vacuum.log"

REM ==========================================
REM CREATE LOG DIRECTORY
REM ==========================================

if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

REM ==========================================
REM START VACUUM ANALYZE
REM ==========================================

echo ========================================== >> "%LOG_FILE%"
echo VACUUM ANALYZE started: %date% %time% >> "%LOG_FILE%"
echo Database: %DATABASE% >> "%LOG_FILE%"

"%PG_BIN%\psql.exe" -U "%DB_USER%" -d "%DATABASE%" -c "VACUUM ANALYZE;" >> "%LOG_FILE%" 2>&1

REM ==========================================
REM VERIFY RESULT
REM ==========================================

if %ERRORLEVEL% EQU 0 (
    echo VACUUM ANALYZE completed successfully. >> "%LOG_FILE%"
    echo VACUUM ANALYZE completed successfully.
) else (
    echo ERROR: VACUUM ANALYZE failed. >> "%LOG_FILE%"
    echo ERROR: VACUUM ANALYZE failed.
)

echo VACUUM ANALYZE finished: %date% %time% >> "%LOG_FILE%"
echo ========================================== >> "%LOG_FILE%"

endlocal