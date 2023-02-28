echo root | sudo -S snap install spotify
echo root | sudo -S sed -i 's/.*enable-deferred-volume.*/enable-deferred-volume = no/' /etc/pulse/daemon.conf && echo ""
pulseaudio -k && pulseaudio --start
