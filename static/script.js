document.getElementById('download-form').addEventListener('submit', function (e) {
    e.preventDefault();

    const formData = new FormData(this);

    fetch('/download', {
        method: 'POST',
        body: formData
    }).then(response => response.json())
      .then(data => {
          if (data.status === 'started') {
              checkProgress();
          }
      });
});

function checkProgress() {
    const progressBar = document.getElementById('progress-bar');
    const statusText = document.getElementById('status');
    const fileNameText = document.getElementById('file-name');

    const interval = setInterval(() => {
        fetch('/progress')
            .then(response => response.json())
            .then(data => {
                progressBar.style.width = data.progress + '%';
                statusText.innerText = data.status;

                if (data.status === 'Completed') {
                    fileNameText.innerText = 'Downloaded File: ' + data.filename;
                    clearInterval(interval);
                }
            });
    }, 1000);
}

document.getElementById('open-folder').addEventListener('click', function () {
    fetch('/open-folder');
});
