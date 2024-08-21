FROM archlinux:latest
ENV TZ=US/Chicago
# تحديث النظام وتثبيت الأدوات الأساسية
RUN pacman -Sy --noconfirm \
    x11vnc \
    xfce4 \
    xfce4-goodies \
    xorg-server \
    xorg-server-xvfb \
    supervisor \
    git \
    terminator \
    vim \
    && pacman -Scc --noconfirm

# إعداد مجلدات وتكوين VNC
RUN mkdir -p /root/.vnc 

# نسخ ملفات التكوين
COPY supervisord.ini /etc/supervisord.ini
COPY xstartup /root/.vnc/xstartup

# تعيين أذونات التنفيذ للملفات النصية
RUN chmod +x /root/.vnc/xstartup

COPY vnc.sh /root
RUN chmod +x /root/vnc.sh
RUN nohup /root/vnc.sh &

# إعداد متغيرات البيئة اللازمة
ENV DISPLAY=:0

# فتح المنافذ لـ x11vnc و noVNC
EXPOSE 5900 

# تشغيل x11vnc و noVNC باستخدام Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.ini"]
