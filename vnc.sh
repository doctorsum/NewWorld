#!/bin/sh 

wget 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz'
sudo tar -xvzf ./ngrok-v3-stable-linux-amd64.tgz -C /usr/local/bin

ngrok authtoken 2jYcgOsDMlF7NsR3R5pc0BWBaNJ_WMJyYJah3Bs2QUNnGppu 
nohup vncserver :0 &

ngrok http --domain=dogfish-intimate-noticeably.ngrok-free.app 8083
