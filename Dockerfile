# استخدم صورة أساسية لأرش (Arch Linux) من Docker Hub
FROM archlinux:latest

# تحديث النظام وتثبيت الأدوات الأساسية
RUN pacman -Sy --noconfirm \
    tigervnc \
    xfce4 \
    xfce4-goodies \
    xorg-server \
    supervisor \
    git \
    terminator \
    vim \
    && pacman -Scc --noconfirm

# إعداد مجلدات وتكوين VNC
RUN mkdir -p /root/.vnc \
    && echo "you4pass72736JHhsjs8273word" | vncpasswd -f > /root/.vnc/passwd \
    && chmod 600 /root/.vnc/passwd

# نسخ ملفات التكوين
COPY supervisord.ini /etc/supervisord.ini
COPY xstartup /root/.vnc/xstartup

# تعيين أذونات التنفيذ للملفات النصية
RUN chmod +x /root/.vnc/xstartup

# تحميل noVNC وتثبيته
WORKDIR /opt/
RUN git clone https://github.com/novnc/noVNC.git

# تجنب عملية أخرى من checkout عند تشغيل noVNC
WORKDIR /opt/noVNC/utils/
RUN git clone https://github.com/kanaka/websockify

# إعداد متغيرات البيئة اللازمة
ENV DISPLAY=:1

# فتح المنافذ لـ VNC و noVNC
EXPOSE 5901 8083

# تشغيل TigerVNC و noVNC باستخدام Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.ini"]
