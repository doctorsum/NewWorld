# استخدم صورة أساسية لأرش (Arch Linux) من Docker Hub
FROM archlinux:latest

# تحديث النظام وتثبيت الأدوات الأساسية
RUN pacman -Sy --noconfirm \
    git \
    xfce4-goodies \
    dnscrypt-proxy \
    tigervnc \
    xfce4 \
    xorg-xinit \
    xorg-server \
    base-devel \
    tor \
    proxychains-ng \
    curl \
    sudo \
    python \
    python-pip

# تثبيت Flask و requests
RUN pip3 install flask requests  --break-system-packages

# إعداد مستودعات BlackArch
RUN curl -O https://blackarch.org/strap.sh \
    && chmod +x strap.sh \
    && ./strap.sh

# تثبيت noVNC من GitHub
RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC \
    && git clone https://github.com/novnc/websockify.git /opt/noVNC/utils/websockify \
    && ln -s /opt/noVNC/vnc_lite.html /opt/noVNC/index.html

# نسخ ملفات التكوين من نفس المجلد الذي يحتوي على Dockerfile إلى الأماكن المناسبة
COPY proxychains.conf /etc/proxychains.conf
COPY torrc /etc/tor/torrc
COPY blocked-ips.txt /etc/dnscrypt-proxy/blocked-ips.txt
COPY dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml

# إعداد مجلدات
RUN mkdir -p /root/u \
    && mkdir /root/h

# نسخ الملفات النصية إلى الحاوية
COPY loading-dns.sh /root/u/loading-dns.sh
COPY loading-tor.sh /root/u/loading-tor.sh
COPY kk.sh /root/u/kk.sh
COPY .bashrc /root/.bashrc

# نسخ example.py إلى الحاوية
COPY example.py /root/example.py

# تعيين أذونات التنفيذ للملفات النصية
RUN chmod +x /root/u/loading-dns.sh \
    && chmod +x /root/u/loading-tor.sh \
    && chmod +x /root/u/kk.sh

# فتح المنافذ المطلوبة
EXPOSE 5901 6080 9051 5000

# إعداد أمر البدء لتشغيل VNC وتقديم واجهة noVNC باستخدام Flask
CMD ["/bin/bash", "-c", "vncserver :0 -SecurityTypes None && python3 /root/example.py"]
