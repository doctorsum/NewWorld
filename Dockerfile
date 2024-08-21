FROM archlinux:latest

RUN pacman -Sy --noconfirm \
    tigervnc \
    xfce4 \
    xfce4-goodies \
    xorg-server \
    xorg-server-xvfb \
    supervisor \
    git \
    terminator \
    vim \
    wget \
    && pacman -Scc --noconfirm

RUN mkdir -p /root/.vnc \
    && echo "Msu4pass72736JHjs8273j3wors" | vncpasswd -f > /root/.vnc/passwd \
    && chmod 600 /root/.vnc/passwd

COPY supervisord.ini /etc/supervisord.ini
COPY xstartup /root/.vnc/xstartup

RUN chmod +x /root/.vnc/xstartup

RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC

ENV DISPLAY=:0

RUN wget 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz'
RUN sudo tar -xvzf ./ngrok-v3-stable-linux-amd64.tgz -C /usr/local/bin

RUN ngrok authtoken 2jYcgOsDMlF7NsR3R5pc0BWBaNJ_WMJyYJah3Bs2QUNnGppu 
EXPOSE 8083

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.ini"]
