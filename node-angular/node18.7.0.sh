wget https://nodejs.org/dist/v18.7.0/node-v18.7.0-linux-x64.tar.xz
if [ -s *.tar.xz ]; then
  echo -e "Download completed.\n"
else
  echo -e "File not downloaded.\n"
  exit 1
fi

tar -xf node*.tar.xz
if [ -d $PWD/node*/ ]; then
  rm node*.tar.xz
  echo -e "Extraction completed.\n"
else
  echo -e "Extraction not performed.\n"
  exit 1
fi

nodefolder=$(basename $PWD/node*/) && echo -e "$nodefolder \n"

echo root | sudo -S echo ""

sudo cp -R node*/ /opt && sudo rm -R node*/ && echo ""
if [ -d /opt/$nodefolder ]; then
  echo -e "Folder moved to /opt directory.\n"
else
  echo -e "Something wrong when moving the directory.\n"
  exit 1
fi

sudo echo "" >> ~/.profile
sudo echo export "NODE_HOME=/opt/$nodefolder" >> ~/.profile
sudo echo 'export PATH=$NODE_HOME/bin:$PATH' >> ~/.profile
if grep -q "export NODE_HOME" ~/.profile; then
  if grep -q 'export PATH=$NODE_HOME' ~/.profile; then
    echo -e "Environment variable added.\n"
  else
    echo -e "Something wrong with adding environment variable.\n"
    exit 1
  fi
fi

source ~/.profile

sudo chown -R $USER:$USER /opt/$nodefolder/
echo -e "Ownership of $nodefolder changed from root to $USER\n"
