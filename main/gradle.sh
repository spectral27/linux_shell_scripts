latestversion=8.0.1

wget https://services.gradle.org/distributions/gradle-${latestversion}-bin.zip
if [ -s gradle-${latestversion}-bin.zip ]; then
  echo -e "Download completed\n"
else
  echo -e "File not downloaded\n"
  exit 1
fi

unzip gradle-${latestversion}-bin.zip
if [ -d $PWD/gradle*/ ]; then
  rm gradle-${latestversion}-bin.zip
  echo -e "Extraction completed\n"
else
  echo -e "Extraction not performed\n"
  exit 1
fi

gradlefolder=$(basename $PWD/gradle*/) && echo -e "${gradlefolder}\n"

if [ ! -d /inst/ ]; then
  echo -e "/inst/ directory not found, creating it\n"
  sudo mkdir /inst/
  sudo chmod a+rwx /inst/
else
  echo -e "/inst/ directory found\n"
fi

if [ -d /inst/${gradlefolder} ]; then
  echo -e "Directory already exists\n"
  sudo rm -rf /inst/${gradlefolder}
  echo -e "Already existing directory deleted\n"
fi

sudo mv ${gradlefolder} /inst/
if [ -d /inst/${gradlefolder} ]; then
  echo -e "Folder moved to /inst/ directory\n"
else
  echo -e "Folder not moved to /inst/ directory\n"
  exit 1
fi

if grep -q "export GRADLE_HOME" ~/.profile && grep -q 'export PATH=$GRADLE_HOME' ~/.profile; then
  echo -e "Previous environment variables for Gradle found\n"
  sed -i '/export GRADLE_HOME.*/d' ~/.profile
  sed -i '/export PATH=$GRADLE_HOME.*/d' ~/.profile
  echo -e "Previous environment variables for Gradle deleted\n"
fi

sudo echo "" >> ~/.profile
sudo echo export GRADLE_HOME=/inst/${gradlefolder} >> ~/.profile
sudo echo 'export PATH=$GRADLE_HOME/bin:$PATH' >> ~/.profile
sudo echo "" >> ~/.profile
if grep -q "export GRADLE_HOME" ~/.profile; then
  if grep -q 'export PATH=$GRADLE_HOME' ~/.profile; then
    echo -e "Environment variables added\n"
  else
    echo -e "Environment variables not added\n"
    exit 1
  fi
fi

echo -e "${gradlefolder} installation completed\n"

