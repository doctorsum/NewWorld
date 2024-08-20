clear
rm /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
clear
cd ~
nohup sudo tor &
bash u/loading-tor.sh
clear
cd ~/h
nohup sudo dnscrypt-proxy -config /etc/dnscrypt-proxy/dnscrypt-proxy.toml &
cd ..
bash u/loading-dns.sh
clear
cd ~/u
nohup sudo ./kk.sh &
clear
cd ..
clear
rm /etc/resolv.conf
echo "nameserver 127.0.0.1#5390" >> /etc/resolv.conf
clear
PS1='\[\033[38;5;159m\]┌──(\[\033[38;5;33m\]\u\[\033[38;5;196m\]{%}\[\033[38;5;33m\]BlackArch\[\033[38;5;159m\])-[\[\033[38;5;250m\]\w\[\033[38;5;159m\]]\n└─\[\033[38;5;159m\]\[\033[38;5;33m\]$\[\033[0m\] '
alias pc='proxychains'
alias ck='pc curl -s http://ip-api.com/json'
alias pacs='pc pacman -S'
alias update='echo "WARNING YOU Update Without ProxyChains be CAREFUL" && pacman -Syu'
alias pacss='pc pacman -Ss'
alias x='clear'
