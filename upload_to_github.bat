@echo off
REM Quick upload script for license files to GitHub
REM Usage: Place in licenses folder and run after generating license

echo ========================================
echo  Skates D2R License Uploader
echo ========================================
echo.

REM Check if git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Git is not installed!
    echo Please install Git for Windows: https://git-scm.com/
    pause
    exit /b
)

REM Check if we're in a git repo
if not exist ".git" (
    echo Initializing Git repository...
    git init -b main
    git remote add origin https://github.com/Stealan1/libcobsys992.git
    echo.
)

REM Get latest changes
echo Pulling latest changes...
git pull origin main
git checkout main 2>nul
echo.

REM Add all .enc files
echo Adding license files...
git add users/*.enc
echo.

REM Commit
set /p LICENSE_KEY="Enter License Key for commit message: "
git commit -m "Add license: %LICENSE_KEY%"
echo.

REM Push to GitHub
echo Uploading to GitHub...
git push origin main
echo.

if errorlevel 1 (
    echo.
    echo ERROR: Upload failed!
    echo.
    echo Make sure you have:
    echo 1. Created the repository: d2r-licenses
    echo 2. Set up GitHub authentication
    echo.
    pause
    exit /b
)

echo ========================================
echo  Upload Complete!
echo ========================================
echo.
echo License files uploaded successfully.
echo Customer can now activate their license.
echo.
pause
