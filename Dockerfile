# استخدم صورة أساسية لأرش (Arch Linux) من Docker Hub
FROM archlinux:latest
RUN pacman -Sy
# تحديث النظام وتثبيت الأدوات الأساسية
RUN pacman -S --noconfirm \
    dnscrypt-proxy \
    tor \
    proxychains-ng \
    curl \
    sudo \
    facter \
    git \
    enlightenment \
    net-tools \
    python \
    supervisor \
    terminator \
    vim \
    x11vnc \
    xorg-server \
    xorg-server-xvfb \
    xorg-xinit \
    xorg-xkill \
    python-numpy \
    mate \
    mate-extra



# إعداد مستودعات BlackArch
RUN curl -O https://blackarch.org/strap.sh \
    && chmod +x strap.sh \
    && ./strap.sh


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
#RUN source /root/.bashrc
# نسخ example.py إلى الحاوية
COPY example.py /root/example.py

# تعيين أذونات التنفيذ للملفات النصية
RUN chmod +x /root/u/loading-dns.sh \
    && chmod +x /root/u/loading-tor.sh \
    && chmod +x /root/u/kk.sh
RUN pacman -Sy

# noVNC cooking
WORKDIR /opt/
RUN git clone https://github.com/kanaka/noVNC.git
# Avoid another checkout when launching noVnc
WORKDIR /opt/noVNC/utils/
RUN git clone https://github.com/kanaka/websockify

# Comfort
WORKDIR /var/log/supervisor/

# Not seems to work, but...
RUN export DISPLAY=:0.0

# Prepare X11, x11vnc, mate and noVNC from supervisor
COPY supervisord.ini /etc/supervisor.d/supervisord.ini

# Be sure that the noVNC port is exposed
EXPOSE 8083

# Launch X11, x11vnc, mate and noVNC from supervisor
CMD ["/usr/bin/supervisord"]
