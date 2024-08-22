from flask import Flask, send_from_directory
import requests
import os

app = Flask(__name__)

@app.route('/')
def index():
    # استرجاع عنوان IP العام باستخدام requests
    response = requests.get('https://api.ipify.org?format=text')
    public_ip = response.text
    return f"""
    <!DOCTYPE html>
    <html>
    <head>
        <title>Public IP</title>
    </head>
    <body>
        <h1>Your Public IP Address</h1>
        <p>Public IP Address: {public_ip}</p>
        <p><a href="/vnc">Go to noVNC Interface</a></p>
    </body>
    </html>
    """

@app.route('/vnc/<path:filename>')
def serve_vnc(filename):
    # تقديم ملفات noVNC من الدليل /opt/noVNC
    return send_from_directory('/app/noVNC', filename)

@app.route('/vnc/')
def vnc_index():
    # تقديم ملف index.html الرئيسي لـ noVNC
    return send_from_directory('/app/noVNC', 'index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
