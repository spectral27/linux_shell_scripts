wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz
if [ -s *.tar.gz ]; then
  echo -e "Download completed\n"
else
  echo -e "File not downloaded\n"
  exit 1
fi

tar -xf jdk*.tar.gz
if [ -d $PWD/jdk*/ ]; then
  rm jdk*.tar.gz
  echo -e "Extraction completed\n"
else
  echo -e "Extraction not performed\n"
  exit 1
fi

jdkfolder=$(basename $PWD/jdk*/) && echo -e "$jdkfolder \n"

if [ -d /opt/$jdkfolder ]; then
  echo -e "Folder already exists\n"
  exit 1
fi

sudo mv jdk*/ /opt && echo -e "\n"
if [ -d /opt/$jdkfolder ]; then
  echo -e "Folder moved to /opt directory\n"
else
  echo -e "Folder not moved to /opt directory\n"
  exit 1
fi

sudo echo "" >> ~/.profile
sudo echo export JAVA_HOME=/opt/$jdkfolder >> ~/.profile
sudo echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.profile
if grep -q "export JAVA_HOME" ~/.profile; then
  if grep -q 'export PATH=$JAVA_HOME' ~/.profile; then
    echo -e "Environment variable added\n"
  else
    echo -e "Environment variable not added\n"
    exit 1
  fi
fi

echo -e "${jdkfolder} installation completed\n"
