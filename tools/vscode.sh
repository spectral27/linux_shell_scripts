filename=vscode.deb

wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' \
-O ./$filename

sudo dpkg --install $filename
rm $filename
