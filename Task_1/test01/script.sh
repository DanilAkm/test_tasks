# Run the file as root if you want it to work ovviamente :)
# I

CUR_ZONE=$(cat /etc/timezone)

if [ "$CUR_ZONE" == "Europe/Moscow" ]; then
    echo 'Timezone already set to Europe/Moscow'
else
    timedatectl set-timezone Europe/Moscow
    echo 'Timezone set to Europe/Moscow'
fi


# II

LOCALE_EXISTS=$(locale -a | grep ru_RU.utf8 -c)

if [[ $LOCALE_EXISTS -gt 0 ]]; then
    echo 'Locale ru_RU.utf8 already in locales'
else
    localectl set-locale ru_RU.UTF-8
    echo 'New locale set'
fi

# III

sudo sed -i 's/#Port 22/Port 2498/' /etc/ssh/sshd_config

# oppure

echo 'Port 2498' >> /etc/ssh/sshd_config

service ssh restart

echo 'Warning: ssh port changed to 2498'

# IV

sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

service ssh restart

# V & VI

useradd serviceuser
usermod -aG sudo serviceuser

# VII

echo 'serviceuser ALL=(ALL) /usr/sbin/service * start, /usr/sbin/service * stop, /usr/sbin/service * restart' >> /etc/sudoers






