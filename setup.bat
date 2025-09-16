@echo off
echo ===============================================
echo 🚀 YouTube Downloader Setup - Easy Install 🚀
echo ===============================================

:: Step 1 – Check for Python
where python
if %ERRORLEVEL% NEQ 0 (
    echo ⚠️ Python is not installed!
    echo Downloading Python installer...
    curl -L https://www.python.org/ftp/python/3.11.6/python-3.11.6-amd64.exe -o python_installer.exe
    echo Installing Python silently...
    start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1
    del python_installer.exe
    echo ✅ Python installed successfully!
)

:: Step 2 – Upgrade pip and install dependencies
echo Installing Python packages (flask, yt-dlp)...
python -m pip install --upgrade pip
python -m pip install flask yt-dlp

:: Step 3 – Check for ffmpeg
where ffmpeg
if %ERRORLEVEL% NEQ 0 (
    echo ⚠️ ffmpeg not found in PATH!
    echo Downloading ffmpeg essential build...
    curl -L https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip -o ffmpeg.zip
    mkdir ffmpeg
    tar -xf ffmpeg.zip -C ffmpeg --strip-components=1
    setx PATH "%CD%\ffmpeg\bin;%PATH%"
    del ffmpeg.zip
    echo ✅ ffmpeg installed.
    echo ⚠️ Please restart terminal to apply PATH changes.
)

:: Step 4 – Create downloads folder
if not exist downloads mkdir downloads

echo ===============================================
echo ✅ Setup Complete! You can now run: python app.py
echo ===============================================
pause
