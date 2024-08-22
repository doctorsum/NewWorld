#!/bin/bash
Xvfb :1 -screen 0 1920x720x24 &

# إعداد متغير DISPLAY
export DISPLAY=:1

startxfce4 &

x11vnc -display :1 -forever -rfbauth /root/.vnc/passwd
