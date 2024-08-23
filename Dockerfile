FROM archlinux:latest
RUN pacman -Syu --noconfirm
RUN pacman -Sy --noconfirm \
    x11vnc \
    xfce4 \
    xfce4-goodies \
    sudo \
    linux \
    linux-firmware \
    base-devel \
    python \
    xorg-xinit \
    python-pip \
    xorg-server \
    xorg-server-xvfb \
    supervisor \
    git \
    terminator \
    vim \
    wget \
    supervisor \
    tar \
    dbus \
    && pacman -Scc --noconfirm

RUN pacman -Syu --noconfirm xfce4 xfce4-goodies dbus
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm xfce4-settings

RUN mkdir /root/.vnc \
    && x11vnc -storepasswd 123hshHs284 /root/.vnc/passwd
COPY start-vnc.sh /start-vnc.sh
RUN chmod +x /start-vnc.sh

RUN mkdir -p /etc/supervisor/conf.d

# إضافة ملف التكوين لـ supervisor إلى المسار الصحيح
COPY supervisord.conf /etc/supervisor/supervisord.conf

COPY xstartup /root/.vnc/xstartup

RUN chmod +x /root/.vnc/xstartup

RUN git clone https://github.com/doctorsum/noVNC.git /opt/noVNC

EXPOSE 6080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
