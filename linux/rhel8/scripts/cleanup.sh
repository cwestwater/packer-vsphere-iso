#!/bin/sh -eux

echo "Disable NetworkManager-wait-online.service"
systemctl disable NetworkManager-wait-online.service

# cleanup current SSH keys so templated VMs get fresh key
rm -f /etc/ssh/ssh_host_*

# Avoid ~200 meg firmware package we don't need
# this cannot be done in the KS file so we do it here
echo "Removing extra firmware packages"
dnf -y remove linux-firmware
dnf -y autoremove

echo "Remove previous kernels that preserved for rollbacks"
dnf -y clean all  --enablerepo=\*;

echo "truncate any logs that have built up during the install"
find /var/log -type f -exec truncate --size=0 {} \;

echo "remove the install log"
rm -f /root/anaconda-ks.cfg /root/original-ks.cfg

echo "remove the contents of /tmp and /var/tmp"
rm -rf /tmp/* /var/tmp/*

echo "Force a new random seed to be generated"
rm -f /var/lib/systemd/random-seed

echo "Wipe netplan machine-id (DUID) so machines get unique ID generated on boot"
truncate -s 0 /etc/machine-id

echo "Clear the history so our install commands aren't there"
rm -f /root/.wget-hsts
export HISTSIZE=0

echo "Remove Subscription"
subscription-manager unregister
subscription-manager remove --all
subscription-manager clean