#!/bin/bash

# إعدادات الألوان
BAR_COLOR='\033[38;5;82m'  # لون أخضر
RESET_COLOR='\033[0m'     # إعادة الضبط إلى اللون الافتراضي

# إعدادات شريط التحميل
total=50  # عدد الخطوات الكلي
width=50   # عرض شريط التحميل في الرموز #
progress=0

# عرض النص المزخرف باستخدام figlet
clear
figlet "BlackArch Starting DNS"
echo  # سطر جديد بعد النص المزخرف

# عرض القوس الأيسر
echo -ne "Loading... ["  # عرض نص التحميل مع القوس الأيسر

# حلقة شريط التحميل
while [ $progress -le $total ]; do
    # حساب النسبة المئوية
    percentage=$((progress * 100 / total))
    
    # حساب عدد الرموز # التي يجب عرضها
    filled=$((progress * width / total))
    
    # إنشاء شريط التحميل
    bar=$(printf "%${filled}s" | tr ' ' '#')
    bar=$(printf "%-${width}s" "$bar")
    
    # عرض شريط التحميل والنسبة المئوية على السطر نفسه
    printf "\rLoading... [${BAR_COLOR}${bar}${RESET_COLOR}] ${percentage}%%"
    
    # زيادة تقدم التحميل
    progress=$((progress + 1))
    
    # تأخير للتوضيح
    sleep 0.005
done

# عرض رسالة عند الانتهاء (يتم عرضها بعد اكتمال التحميل)
echo -e "\rLoading... [${BAR_COLOR}$(printf "%${width}s" | tr ' ' '#')${RESET_COLOR}] 100% ${BAR_COLOR}\nStarting DNS-Crypt Proxy Done!${RESET_COLOR}"
