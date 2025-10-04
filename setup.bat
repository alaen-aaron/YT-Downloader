@echo off
title 🚀 YouTube Downloader Project Setup
echo ================================================
echo   🚀 YouTube Downloader Setup - Full Auto Install
echo ================================================
echo.

:: =============================
:: Step 1 – Install / Update Python (Latest)
:: =============================
where python >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ⚠️ Python not found. Installing latest version...
    curl -L -o python_installer.exe https://www.python.org/ftp/python/3.12.6/python-3.12.6-amd64.exe
    echo Installing Python silently...
    start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    del python_installer.exe
    echo ✅ Python installed successfully!
) else (
    echo ✅ Python already installed. Checking version...
    python --version
)

:: Force refresh PATH (new terminals will use updated path)
set PATH=%PATH%;C:\Python312;C:\Python312\Scripts

:: =============================
:: Step 2 – Upgrade pip
:: =============================
echo.
echo 🔄 Upgrading pip...
python -m ensurepip --upgrade
python -m pip install --upgrade pip setuptools wheel

:: =============================
:: Step 3 – Install yt-dlp (latest nightly build)
:: =============================
echo.
echo 📥 Installing latest yt-dlp (nightly)...
pip install -U https://github.com/yt-dlp/yt-dlp/archive/master.tar.gz

:: =============================
:: Step 4 – Install Flask + required Python libs
:: =============================
echo.
echo 📦 Installing Flask and dependencies...
pip install flask requests

:: =============================
:: Step 5 – Install ffmpeg
:: =============================
where ffmpeg >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ⚠️ ffmpeg not found. Installing...
    curl -L -o ffmpeg.zip https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip
    mkdir ffmpeg
    powershell -command "Expand-Archive ffmpeg.zip -DestinationPath ffmpeg -Force"
    del ffmpeg.zip
    for /d %%i in (ffmpeg\ffmpeg-*) do set ffdir=%%i
    move %ffdir%\bin ffmpeg\bin >nul
    rmdir /s /q %ffdir%
    setx PATH "%CD%\ffmpeg\bin;%PATH%"
    echo ✅ ffmpeg installed. Restart terminal if PATH not updated.
) else (
    echo ✅ ffmpeg already installed.
)

:: =============================
:: Step 6 – Setup project folder
:: =============================
if not exist ytdlp_flask_project (
    mkdir ytdlp_flask_project
    cd ytdlp_flask_project
    echo from flask import Flask>app.py
    echo app = Flask(__name__)>>app.py
    echo @app.route('/')>>app.py
    echo def home(): return "Hello, YouTube Downloader Ready!">>app.py
    echo if __name__ == "__main__": app.run(debug=True, port=5000)>>app.py
    echo ✅ Project folder created with starter app.py
) else (
    echo ✅ Project folder already exists.
)

:: =============================
:: Final message
:: =============================
echo.
echo ================================================
echo 🎉 Setup Complete! 
echo 👉 Next steps:
echo    cd ytdlp_flask_project
echo    python app.py
echo ================================================
pause
