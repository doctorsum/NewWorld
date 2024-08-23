#!/bin/bash

# تشغيل Xvfb (إذا لم يكن لديك X Server)
Xvfb :1 -screen 0 1024x768x24 &

# الانتظار لبضع ثواني للتأكد من أن Xvfb بدأ
sleep 2

# إعداد متغير DISPLAY
export DISPLAY=:1

# بدء جلسة XFCE4
startxfce4 &

# الانتظار لبضع ثواني للتأكد من أن XFCE4 بدأ
sleep 2

# تشغيل x11vnc
x11vnc -display :1 -forever -rfbauth /root/.vnc/passwd
