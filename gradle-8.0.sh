wget https://services.gradle.org/distributions/gradle-8.0-bin.zip
if [ -s gradle-8.0-bin.zip ]; then
  echo -e "Download completed\n"
else
  echo -e "File not downloaded\n"
  exit 1
fi

unzip gradle-8.0-bin.zip
if [ -d $PWD/gradle*/ ]; then
  rm gradle-8.0-bin.zip
  echo -e "Extraction completed\n"
else
  echo -e "Extraction not performed\n"
  exit 1
fi

gradlefolder=$(basename $PWD/gradle*/) && echo -e "$gradlefolder\n"

if [ -d /opt/$gradlefolder ]; then
  echo -e "Folder already exists\n"
  sudo rm -rf /opt/$gradlefolder
  echo -e "Already existing folder deleted\n"
fi

sudo mv $gradlefolder /opt
if [ -d /opt/$gradlefolder ]; then
  echo -e "Folder moved to /opt directory\n"
else
  echo -e "Folder not moved to /opt directory\n"
  exit 1
fi

if grep -q "export GRADLE_HOME" ~/.profile && grep -q 'export PATH=$GRADLE_HOME' ~/.profile; then
  echo -e "Previous environment variables for Gradle found\n"
  sed -i '/export GRADLE_HOME.*/d' ~/.profile
  sed -i '/export PATH=$GRADLE_HOME.*/d' ~/.profile
  echo -e "Previous environment variables for Gradle deleted\n"
fi

sudo echo "" >> ~/.profile
sudo echo export GRADLE_HOME=/opt/$gradlefolder >> ~/.profile
sudo echo 'export PATH=$GRADLE_HOME/bin:$PATH' >> ~/.profile
if grep -q "export GRADLE_HOME" ~/.profile; then
  if grep -q 'export PATH=$GRADLE_HOME' ~/.profile; then
    echo -e "Environment variables added\n"
  else
    echo -e "Environment variables not added\n"
    exit 1
  fi
fi

echo -e "${gradlefolder} installation completed\n"
