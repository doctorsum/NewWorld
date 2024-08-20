#!/bin/bash

while true; do
    # إرسال إشارة لتدوير عنوان الـ IP
    (echo authenticate '""'; echo signal newnym; echo quit) | curl -s telnet://localhost:9051
    sleep 1
done
