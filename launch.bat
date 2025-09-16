@echo off
echo 🚀 Launching YouTube Downloader App...

:: Start the Flask app
start /B python app.py

:: Wait a few seconds to let Flask start
timeout /t 5 > nul

:: Open default browser at Flask URL
start http://127.0.0.1:5000

echo ✅ App running at http://127.0.0.1:5000
pause
