#!/bin/bash
# تشغيل Xvfb (إذا لم يكن لديك X Server)
Xvfb :1 -screen 0 1920x720x24 &

# تشغيل x11vnc
x11vnc -display :1 -forever -rfbauth /root/.vnc/passwd
