sudo snap install spotify
sudo sed -i 's/.*enable-deferred-volume.*/enable-deferred-volume = no/' /etc/pulse/daemon.conf && echo ""
pulseaudio -k && pulseaudio --start

