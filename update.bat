@echo off
title YouTube Downloader Project Setup
echo ==========================================
echo   Setting up YouTube Downloader Project
echo ==========================================
echo.

:: Step 1 - Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python not found. Installing Python 3.12...
    curl -L -o python-installer.exe https://www.python.org/ftp/python/3.12.6/python-3.12.6-amd64.exe
    start /wait python-installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    del python-installer.exe
    echo Python installed!
) else (
    echo Python already installed.
)

:: Refresh PATH
set PATH=%PATH%;C:\Python312\Scripts;C:\Python312

:: Step 2 - Install pip packages (upgrade first)
echo.
echo Upgrading pip...
python -m pip install --upgrade pip

:: Step 3 - Install/Upgrade yt-dlp (latest nightly build for bug fixes)
echo.
echo Installing latest yt-dlp...
pip install -U https://github.com/yt-dlp/yt-dlp/archive/master.tar.gz

:: Step 4 - Install Flask
echo.
echo Installing Flask...
pip install flask

:: Step 5 - Install other dependencies
echo.
echo Installing extra dependencies...
pip install requests

:: Step 6 - Install ffmpeg (via chocolatey if missing)
where ffmpeg >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ffmpeg not found. Installing via Chocolatey...
    powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; \
      [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
      iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    choco install -y ffmpeg
) else (
    echo ffmpeg already installed.
)

:: Step 7 - Create project folder
echo.
if not exist ytdlp_flask_project (
    mkdir ytdlp_flask_project
    cd ytdlp_flask_project
    echo from flask import Flask > app.py
    echo app = Flask(__name__) >> app.py
    echo @app.route('/') >> app.py
    echo def home(): return "Hello, YouTube Downloader Ready!" >> app.py
    echo if __name__ == "__main__": app.run(debug=True, port=5000) >> app.py
    echo Project folder created with starter app.py
) else (
    echo Project folder already exists.
)

echo.
echo ==========================================
echo   Setup Complete! 
echo Run your app with:
echo   cd ytdlp_flask_project
echo   python app.py
echo ==========================================
pause
