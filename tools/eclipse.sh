wget -O eclipse.tar.gz https://eclipse.mirror.garr.it/technology/epp/downloads/release/2022-06/R/eclipse-jee-2022-06-R-linux-gtk-x86_64.tar.gz
if [ -s *.tar.gz ]; then
  echo -e "Download completed.\n"
else
  echo -e "File not downloaded.\n"
  exit 1
fi

tar -xf eclipse.tar.gz
if [ -d $PWD/eclipse/ ]; then
  rm eclipse.tar.gz
  echo -e "Extraction completed.\n"
else
  echo -e "Extraction not performed.\n"
  exit 1
fi

sudo cp -R eclipse/ ~ && sudo rm -R eclipse/ && echo -e "\n"
if [ -d ~/eclipse ]; then
  echo -e "Folder moved to /opt directory.\n"
else
  echo -e "Something wrong with moving the directory.\n"
  exit 1
fi

touch Eclipse.desktop
echo -e "[Desktop Entry]\nVersion=1.0" >> Eclipse.desktop
echo -e "Type=Application\nName=Eclipse" >> Eclipse.desktop
echo -e "Exec=/home/$USER/eclipse/eclipse" >> Eclipse.desktop
echo -e "Icon=/home/$USER/eclipse/icon.xpm" >> Eclipse.desktop
echo -e "Terminal=false\nCategories=Development" >> Eclipse.desktop
echo root | sudo -S mv Eclipse.desktop /usr/share/applications
if [ -s /usr/share/applications/Eclipse.desktop ]; then
  echo -e "Launcher successfully created.\n"
else
  echo -e "Something went wrong when creating the launcher.\n"
fi

