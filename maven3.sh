version=3.9.0

wget https://dlcdn.apache.org/maven/maven-3/${version}/binaries/apache-maven-${version}-bin.tar.gz

if [ -s *.tar.gz ]; then
  echo -e "Download completed.\n"
else
  echo -e "File not downloaded.\n"
  exit 1
fi

tar -xf apache*.tar.gz
if [ -d $PWD/apache*/ ]; then
  rm apache*.tar.gz
  echo -e "Extraction completed.\n"
else
  echo -e "Extraction not performed.\n"
  exit 1
fi

mavenfolder=$(basename $PWD/apache*/) && echo -e "$mavenfolder\n"

if [ ! -d /inst/ ]; then
  echo -e "/inst/ directory not found, creating it\n"
  sudo mkdir /inst/
  sudo chmod a+rwx /inst/
else
  echo -e "/inst/ directory found\n"
fi

if [ -d /inst/$mavenfolder ]; then
  echo -e "/inst/${mavenfolder} folder already exists\n"
  sudo rm -rf /inst/$mavenfolder
  echo -e "Already existing folder deleted\n"
fi

sudo mv apache*/ /inst/
if [ -d /inst/$mavenfolder ]; then
  echo -e "Folder moved to /inst/ directory.\n"
else
  echo -e "Folder not moved to /inst directory\n"
  exit 1
fi

if grep -q "export MAVEN_HOME" ~/.profile && grep -q 'export PATH=$MAVEN_HOME' ~/.profile; then
  echo -e "Previous environment variables for Maven found\n"
  sed -i '/export MAVEN_HOME.*/d' ~/.profile
  sed -i '/export PATH=$MAVEN_HOME.*/d' ~/.profile
  echo -e "Previous environment variables for Maven deleted\n"
fi

sudo echo "" >> ~/.profile
sudo echo export MAVEN_HOME=/inst/$mavenfolder >> ~/.profile
sudo echo 'export PATH=$MAVEN_HOME/bin:$PATH' >> ~/.profile
sudo echo "" >> ~/.profile
if grep -q "export MAVEN_HOME" ~/.profile; then
  if grep -q 'export PATH=$MAVEN_HOME' ~/.profile; then
    echo -e "Environment variable added\n"
  else
    echo -e "Environment variable not added\n"
    exit 1
  fi
fi

echo -e "${mavenfolder} installation completed\n"

