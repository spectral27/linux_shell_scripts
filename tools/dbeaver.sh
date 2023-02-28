filename=dbeaver.deb

wget 'https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb' -O $filename

sudo dpkg --install $filename
rm $filename
