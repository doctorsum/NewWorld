FROM archlinux:latest

RUN pacman -Sy --noconfirm \
    tigervnc \
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
    && pacman -Scc --noconfirm

RUN mkdir -p /root/.vnc \
    && echo "Msu4pass72736JHjs8273j3wors" | vncpasswd -f > /root/.vnc/passwd \
    && chmod 600 /root/.vnc/passwd

COPY supervisord.ini /etc/supervisord.ini
COPY xstartup /root/.vnc/xstartup

RUN chmod +x /root/.vnc/xstartup

RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC

ENV DISPLAY=:0

EXPOSE 6080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.ini"]
