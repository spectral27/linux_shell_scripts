filename=insomnia.deb

wget 'https://updates.insomnia.rest/downloads/ubuntu/latest?&app=com.insomnia.app&source=website' \
-O $filename

sudo dpkg --install $filename
rm $filename
