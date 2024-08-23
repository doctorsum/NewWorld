#!/bin/bash
# تشغيل Xvfb (إذا لم يكن لديك X Server)
Xvfb :1 -screen 0 1024x768x24 &

# إعداد متغير DISPLAY
export DISPLAY=:1

# بدء جلسة XFCE4
startxfce4 &

# تشغيل x11vnc
x11vnc -display :1 -forever -rfbauth /root/.vnc/passwd -rfbport 5900 -shared
