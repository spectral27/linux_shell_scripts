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

jdkfolder=$(basename $PWD/jdk*/) && echo -e "$jdkfolder\n"

if [ ! -d /inst/ ]; then
  echo -e "/inst directory not found, creating it\n"
  sudo mkdir /inst/
  sudo chmod a+rwx /inst/
fi

if [ -d /inst/$jdkfolder ]; then
  echo -e "Folder already exists\n"
  sudo rm -rf /inst/$jdkfolder
  echo -e "Already existing folder deleted\n"
fi

sudo mv jdk*/ /inst/
if [ -d /inst/$jdkfolder ]; then
  echo -e "Folder moved to /inst directory\n"
else
  echo -e "Folder not moved to /inst directory\n"
  exit 1
fi

if grep -q "export JAVA_HOME" ~/.profile && grep -q 'export PATH=$JAVA_HOME' ~/.profile; then
  echo -e "Previous environment variables for Java found\n"
  sed -i '/export JAVA_HOME.*/d' ~/.profile
  sed -i '/export PATH=$JAVA_HOME.*/d' ~/.profile
  echo -e "Previous environment variables for Java deleted\n"
fi

sudo echo "" >> ~/.profile
sudo echo export JAVA_HOME=/inst/$jdkfolder >> ~/.profile
sudo echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.profile
sudo echo "" >> ~/.profile
if grep -q "export JAVA_HOME" ~/.profile; then
  if grep -q 'export PATH=$JAVA_HOME' ~/.profile; then
    echo -e "Environment variable added\n"
  else
    echo -e "Environment variable not added\n"
    exit 1
  fi
fi

echo -e "${jdkfolder} installation completed\n"

