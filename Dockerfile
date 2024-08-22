FROM archlinux:latest

RUN pacman -Sy --noconfirm \
    x11vnc \
    xfce4 \
    xfce4-goodies \
    sudo \
    xorg-server \
    xorg-server-xvfb \
    supervisor \
    git \
    terminator \
    vim \
    wget \
    tar \
    dbus \
    && pacman -Scc --noconfirm

RUN pacman -Syu --noconfirm xfce4 xfce4-goodies dbus
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm xfce4-settings

COPY supervisord.ini /etc/supervisord.ini
COPY xstartup /root/.vnc/xstartup

RUN chmod +x /root/.vnc/xstartup

RUN git clone https://github.com/doctorsum/noVNC.git /opt/noVNC

EXPOSE 6080
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.ini"]
