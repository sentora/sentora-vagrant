#!/usr/bin/env bash

# /Devconfig/#provisionsParams & /setup/Sentora.rb # config.vm.provision
# $1 = subDomain
# $2 = zadminPass
# $3 = rootMySqlPass
# $4 timeZone

PACKAGE_INSTALLER="apt-get -yqq install"

$PACKAGE_INSTALLER dnsutils wget tzdata

[ -f /etc/init.d/apparmor ]
if [ $? = "0" ]; then
    echo -e "\n-- Disabling and removing AppArmor, please wait..."
    /etc/init.d/apparmor stop &> /dev/null
    update-rc.d -f apparmor remove &> /dev/null
    apt-get remove -y --purge apparmor* &> /dev/null
    disable_file /etc/init.d/apparmor &> /dev/null
    echo -e "AppArmor has been removed."
fi

#######
echo -ne "\nUpdating Aptitude Repos: " >/dev/tty

    mkdir -p "/etc/apt/sources.list.d.save"
    cp -R "/etc/apt/sources.list.d/*" "/etc/apt/sources.list.d.save" &> /dev/null
    rm -rf "/etc/apt/sources.list/*"
    cp "/etc/apt/sources.list" "/etc/apt/sources.list.save"

########

cat > /etc/apt/sources.list <<EOF
#Depots main restricted
deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-security main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-updates main restricted universe multiverse
EOF

#######

dpkg --get-selections
apt-get -yqq update
apt-get -yqq upgrade
#######

$PACKAGE_INSTALLER sudo vim make zip unzip debconf-utils at build-essential bash-completion

#######

# @ #--- Set-up Sentora directories and configure permissions