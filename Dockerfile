# استخدم صورة أساسية لأرش (Arch Linux) من Docker Hub
FROM archlinux:latest

# تحديث النظام وتثبيت الأدوات الأساسية
RUN pacman -Sy --noconfirm \
    x11vnc \
    xfce4 \
    xfce4-goodies \
    xorg-server \
    supervisor \
    git \
    terminator \
    vim \
    && pacman -Scc --noconfirm

# نسخ ملفات التكوين
COPY supervisord.ini /etc/supervisord.ini

# تحميل noVNC وتثبيته
WORKDIR /opt/
RUN git clone https://github.com/novnc/noVNC.git

# إعداد متغيرات البيئة اللازمة
ENV DISPLAY=:0

# فتح المنافذ لـ x11vnc و noVNC
EXPOSE 5900 8083

# تشغيل x11vnc و noVNC باستخدام Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.ini"]
