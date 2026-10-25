

# Раздел 1. Установка дистрибутива (5 баллов)

# === task 1.1 ===
ip a > ip-output
echo $(cat ip-output) 
echo "[  DONE  ] task 1.2"

# === task 1.2 ===
hostnamectl set-hostname mephi-2026.domain.local
echo "[  DONE  ] task 1.2"

# === task 1.3 ===
ping -c 4 8.8.8.8 > ping.out
echo "[  DONE  ] task 1.3"

# Раздел 2. Управление программным обеспечением (5 баллов)

# === task 2.1 ===
dnf update -y
echo echo "[  DONE  ] task 2.1"

# === task 2.2 ===
dnf install -y nginx libcap-ng-utils acl
echo "[  DONE  ] task 2.2"

# === task 2.3 ==="
mkdir -p /tmp/packages
dnf download tcpdump --resolve --destdir /tmp/packages
rpm -ivh /tmp/packages/tcpdump*.rpm
dnf history > dnf.out
echo "[  DONE  ] task 2.3"


# Раздел 3. Управление файловыми системами (5 баллов)

# === task 3.1 ===
parted -s /dev/sdb mklabel gpt
parted -s /dev/sdb mkpart primary ext4 0% 100%
mkfs.ext4 -L MEPHI_WEB /dev/sdb1
echo "[  DONE  ] task 3.1"

# === task 3.2 ===
mkdir /mephi-web
echo 'LABEL=MEPHI_WEB /mephi-web ext4 defaults 1 2' >> /etc/fstab
systemctl daemon-reload
mount -a
echo "[  DONE  ] task 3.2"

# Раздел 4. Управление сервисами (5 баллов)

# === task 4.1 ===
systemctl start nginx
systemctl enable nginx
echo "[  DONE  ] task 4.1"

# === task 4.2 ===
journalctl -u nginx -b > journalctl.out
echo "[  DONE  ] task 4.1"


# Раздел 5. Управление доступом (15 баллов)

# === task 5.1 ==="
mkdir -p -m 2770 /data/mephi-2026

groupadd users
groupadd -g 4444 curators

chgrp users /datamephi-2026

useradd -u 5501 -m -G users user1 
useradd -u 5502 -m -G users user2
useradd -u 5503 -m -G users user3

useradd -m -G curators curator1
useradd -m -G curators curator2

setfacl -m g:curators:r-X -m d:g:curators:r-X /data/mephi-2026

echo "[  DONE  ] task 5.1"


# === task 5.2 ===
chmod u-s /usr/sbin/tcpdump
setcap cap_net_raw,cap_net_admin+eip /usr/sbin/tcpdump

sudo -u user1 tcpdump -i any -c 4 > tcp.dump

echo "[  DONE  ] task 5.2"


# === task 5.3 ===
semanage fcontext -a -t httpd_sys_content_t '/mephi-web(/.*)?'
restorecon -Rv /mephi-web
getenforce

echo "[  DONE  ] task 5.3"


# Раздел 6. Аутентификация (5 баллов)

# === task 6.1 ===
usermod -s /sbin/nologin curator1
usermod -s /sbin/nologin curator2

# === task 6.2 ===
chage -M 90 user1
chage -M 90 user2
chage -M 90 user3
chage -M 90 curator1
chage -M 90 curator2
echo 'minlen = 12' >> /etc/security/pwquality.conf

echo "[  DONE  ] task 6.1"


# Раздел 7. Тестирование (5 баллов)

# === task 7.1 ===

echo 'Hello from Student: 12345' > /mephi-web/index.html
chmod 664 /mephi-web/index.html
chgrp users /mephi-web/index.html
restorecon -Rv /mephi-web

echo "[  DONE  ] task 7.1"

# === task 7.2 ===
curl http://localhost/

echo "[  DONE  ] task 7.2"


# Раздел 8. Публикация результатов на GitHub (ОБЯЗАТЕЛЬНО, 5 баллов, без этого задание не принимается)

# === task 8.1 ===
history > history.out
ping -c 4 8.8.8.8 > ping.out
stat /data/mephi-2026 > stat.out
stat /mephi-web >> stat.out
getcap /usr/sbin/tcpdump > getcap.out
dnf history > dnf.out
journalctl -u nginx -b > journalctl.out
getenforce > getenforce.out
curl http://localhost/ > curl.out

echo "[  DONE  ] task 8.1"

# === task 8.2 ===

cp /etc/passwd ./passwd
cp /etc/shadow ./shadow
cp /etc/group ./group
cp /etc/fstab ./fstab
cp /etc/security/pwquality.conf ./pwquality.conf

echo "[  DONE  ] task 8.2"

git init

