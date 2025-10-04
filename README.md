# ⚡ YT-Downloader

An **interactive YouTube downloader** powered by **Flask + Python + yt-dlp + ffmpeg**.  
Download **MP4 videos** or **MP3 audio**, choose your quality, watch real-time progress, and even open the downloads folder directly — all from a sleek **cyber-neon styled UI**.  

✨ Future updates will bring **multi-download**, **multi-platform support**, and more powerful customization options.

---

## 🎯 Features
- 🎬 **Video & Audio Downloads** – MP4 video or MP3 audio.
- 📌 **Quality Selection** – Best, High, Medium, or Low.
- ⏳ **Live Progress Bar** – See download progress in real time.
- 🗂️ **Open Downloads Folder** – Jump straight to your downloaded files.
- 🎨 **Futuristic Cyber-Neon UI** – Styled with animations and interactive design.
- 🔄 **Unique Filenames** – Avoids overwriting files.
- ⚡ **Upcoming Features** – Multiple URLs, playlist support, cross-platform build.

---

## 🛠️ Setup

### ✅ Automatic Setup (Recommended)
Just run the provided script — it installs **Python (latest), pip, Flask, yt-dlp, and ffmpeg** for you.

```powershell
update.bat
```

That’s it! After installation:

```powershell
python app.py
```

Then open your browser at 👉 `http://127.0.0.1:5000/`

---

### 🧑‍💻 Manual Setup (Advanced Users)

If you prefer to install everything yourself:

1. Install [Python 3.11+](https://www.python.org/downloads/)  
2. Install [ffmpeg](https://ffmpeg.org/download.html) and add it to your PATH  
3. Install dependencies:
   ```bash
   pip install --upgrade pip
   pip install flask yt-dlp
   ```
4. Run the app:
   ```bash
   python app.py
   ```

---

## 📂 Project Structure
```
YT-Downloader/
│── app.py            # Flask backend
│── templates/        # HTML templates (frontend)
│── static/           # CSS, JS, icons, neon effects
│── downloads/        # Auto-created folder for output files
│── update.bat        # One-click installer for Windows
│── README.md         # You are here
```

---

## 🚀 Usage
1. Paste a YouTube URL  
2. Select **Audio or Video**  
3. Choose quality  
4. Watch the neon **progress bar** glow ⚡  
5. Get your file instantly in the **downloads/** folder  

---

## 🔧 Troubleshooting
- ❌ **Download folder empty?**  
  Run `update.bat` again to reinstall **yt-dlp** and **ffmpeg**.  
- ❌ **Flask not found?**  
  Run:  
  ```bash
  pip install flask
  ```
- ❌ **ffmpeg not recognized?**  
  Restart terminal after running `update.bat`.

---

## 💡 Contributing
PRs, issues, and feature requests are welcome!  
Future roadmap includes:
- 📑 Playlist & bulk downloads  
- 📲 Android / cross-platform support  
- 🌐 Drag & Drop + clipboard integration  

---

## ⚖️ Disclaimer
This tool is for **educational and personal use only**.  
Downloading copyrighted content without permission may violate YouTube’s Terms of Service.

---

### ⭐ If you like this project, don’t forget to **star the repo**!
