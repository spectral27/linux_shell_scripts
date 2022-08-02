filename=dbeaver.deb

wget 'https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb' -O $filename

echo root | sudo -S echo ""

sudo dpkg --install $filename
rm $filename
