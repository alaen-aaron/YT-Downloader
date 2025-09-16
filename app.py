from flask import Flask, render_template, request, jsonify
import subprocess
import threading
import re
import os
import platform

app = Flask(__name__)
DOWNLOAD_FOLDER = 'downloads'
if not os.path.exists(DOWNLOAD_FOLDER):
    os.makedirs(DOWNLOAD_FOLDER)

progress_status = {'progress': 0, 'status': 'Idle', 'filename': ''}


def sanitize_filename(name):
    # Remove illegal characters for filenames
    return re.sub(r'[\\/:"*?<>|]+', '', name)


def get_unique_filepath(title, ext):
    base_filename = sanitize_filename(title)
    filepath = os.path.join(DOWNLOAD_FOLDER, f"{base_filename}.{ext}")

    counter = 1
    while os.path.exists(filepath):
        filepath = os.path.join(DOWNLOAD_FOLDER, f"{base_filename} ({counter}).{ext}")
        counter += 1

    return filepath


def download_media(url, quality, media_type):
    global progress_status
    progress_status['progress'] = 0
    progress_status['status'] = 'Downloading...'
    progress_status['filename'] = ''

    quality_map = {
        'best': 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]',
        'high': 'bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[height<=1080][ext=mp4]',
        'medium': 'bestvideo[height<=720][ext=mp4]+bestaudio[ext=m4a]/best[height<=720][ext=mp4]',
        'low': 'bestvideo[height<=480][ext=mp4]+bestaudio[ext=m4a]/best[height<=480][ext=mp4]',
    }
    format_option = quality_map.get(quality, 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]')

    # Extract video title without downloading
    title_command = [
        'yt-dlp',
        '--get-title',
        url
    ]
    result = subprocess.run(title_command, capture_output=True, text=True)
    video_title = result.stdout.strip()

    if media_type == 'audio':
        target_filepath = get_unique_filepath(video_title, 'mp3')
        command = [
            'yt-dlp',
            '-f', 'bestaudio[ext=m4a]',
            '--extract-audio',
            '--audio-format', 'mp3',
            '--audio-quality', '0',
            '-o', target_filepath,
            url
        ]
    else:
        target_filepath = get_unique_filepath(video_title, 'mp4')
        command = [
            'yt-dlp',
            '-f', format_option,
            '--merge-output-format', 'mp4',
            '-o', target_filepath,
            url
        ]

    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)

    for line in process.stdout:
        match = re.search(r'(\d{1,3}\.\d)%', line)
        if match:
            try:
                progress = float(match.group(1))
                progress_status['progress'] = int(progress)
            except:
                pass

    process.wait()
    progress_status['progress'] = 100
    progress_status['status'] = 'Completed'
    progress_status['filename'] = os.path.basename(target_filepath)


@app.route('/')
def launch():
    return render_template('launch.html')


@app.route('/index')
def index():
    return render_template('index.html')



@app.route('/download', methods=['POST'])
def download():
    global progress_status
    url = request.form['url']
    quality = request.form['quality']
    media_type = request.form['media_type']

    threading.Thread(target=download_media, args=(url, quality, media_type)).start()

    return jsonify({'status': 'started'})


@app.route('/progress')
def progress():
    return jsonify(progress_status)


@app.route('/open-folder', methods=['GET'])
def open_folder():
    path = os.path.abspath(DOWNLOAD_FOLDER)

    try:
        if platform.system() == 'Windows':
            subprocess.Popen(['powershell', '-Command', f'Start-Process explorer "{path}"'])
        elif platform.system() == 'Darwin':
            subprocess.Popen(['open', path])
        else:
            subprocess.Popen(['xdg-open', path])
        return jsonify({'status': 'folder opened'})
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)})


if __name__ == '__main__':
    app.run(debug=True)
