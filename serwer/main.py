import os
from multiprocessing import Process
from flask import Flask, request, redirect, send_from_directory, url_for
from subprocess import call
from shutil import copyfile
from werkzeug.utils import secure_filename
import threading

# set the project root directory as the static folder, you can set others.
UPLOAD_FOLDER = ''
ALLOWED_EXTENSIONS = set(['wav'])
app = Flask(__name__, static_url_path='/')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

app.debug = True
working = False


def calcFork():
	call(["octave", "--no-gui", "6/main.m"])
	working = False

# kazde zadanie obliczeniowe uruchamiane jest w osobnym watku
class WatekOblicz(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
    def run(self):
        result = calcFork()      
        
@app.route('/')
@app.route('/start')
def start():
    if os.path.isfile("out.png"):
       os.remove("out.png")
    if os.path.isfile("pattern.wav"):
       os.remove("pattern.wav")
    if os.path.isfile("data.wav"):
       os.remove("data.wav")
    return send_from_directory('', 'settings.html')
    
@app.route('/settings.html')
def send_settings():
    return send_from_directory('', 'settings.html')

@app.route('/calc')
def calc():
    print("working...")
    working = True
    #WatekOblicz().start()
    #call(["octave", "--no-gui", "5/main.m"])
    p = Process(target=calcFork())
    p.start()
    return send_from_directory('', "waiting.html")


@app.route('/<path:path>')
def root_send(path):
    return send_from_directory('', path)

@app.route('/waiting')
def waiting():
	if working:
	    return send_from_directory('', "waiting.html")
	else:
	    return send_from_directory('', "ans.html")

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS

@app.route('/data', methods=['GET', 'POST'])
def upload_data():
    if request.method == 'POST':
        file = request.files['file']
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], "data.wav"))
    	    return send_from_directory('', "setData.html")
    return send_from_directory('', "setData.html")
    
@app.route('/pattern', methods=['GET', 'POST'])
def upload_pattern():
    if request.method == 'POST':
        file = request.files['file']
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], "pattern.wav"))
    	    return send_from_directory('', "setPattern.html")
    return send_from_directory('', "setPattern.html")


if __name__ == "__main__":
    app.run()
