# استخدم صورة أساسية لأرش (Arch Linux) من Docker Hub
FROM archlinux:latest

# تحديث النظام وتثبيت الأدوات الأساسية
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm git \
    && pacman -S --noconfirm xfce4-goodies \
    && pacman -S --noconfirm dnscrypt-proxy \
    && pacman -S --noconfirm novnc \
    && pacman -S --noconfirm tigervnc \
    && pacman -S --noconfirm xfce4 \
    && pacman -S --noconfirm xorg-xinit \
    && pacman -S --noconfirm xorg-server \
    && pacman -S --noconfirm base-devel \
    && pacman -S --noconfirm tor \
    && pacman -S --noconfirm proxychains-ng \
    && pacman -S --noconfirm curl \
    && pacman -S --noconfirm sudo
# إعداد مستودعات BlackArch
RUN curl -O https://blackarch.org/strap.sh \
    && chmod +x strap.sh \
    && ./strap.sh

# تحديث الحزم وتثبيت مجموعة أدوات BlackArch (اختياري)
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm blackarch

# نسخ ملفات التكوين من نفس المجلد الذي يحتوي على Dockerfile إلى الأماكن المناسبة
COPY proxychains.conf /etc/proxychains.conf
COPY torrc /etc/tor/torrc
COPY blocked-ips.txt /etc/dnscrypt-proxy/blocked-ips.txt
COPY dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml
RUN mkdir -p /root/u
RUN mkdir /root/h
# نسخ الملفات النصية إلى الحاوية
COPY loading-dns.sh /root/u/loading-dns.sh
COPY loading-tor.sh /root/u/loading-tor.sh
COPY kk.sh /root/u/kk.sh
COPY .bashrc /root/.bashrc

# تعيين أذونات التنفيذ للملفات النصية
RUN chmod +x /root/u/loading-dns.sh \
    && chmod +x /root/u/loading-tor.sh \
    && chmod +x /root/u/kk.sh

# فتح المنافذ المطلوبة
EXPOSE 5901 6080 9051

# إعداد أمر البدء
CMD ["/bin/bash"]
