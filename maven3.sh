wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
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

mavenfolder=$(basename $PWD/apache*/) && echo -e "$mavenfolder \n"

echo root | sudo -S cp -R apache*/ /opt && sudo -S rm -R apache*/ && echo -e "\n"
if [ -d /opt/$mavenfolder ]; then
  echo -e "Folder moved to /opt directory.\n"
else
  echo -e "Something wrong with moving the directory.\n"
  exit 1
fi

echo root | sudo -S echo "" >> ~/.profile
echo root | sudo -S echo export MAVEN_HOME=/opt/$mavenfolder >> ~/.profile
echo root | sudo -S echo 'export PATH=$MAVEN_HOME/bin:$PATH' >> ~/.profile
if grep -q "export MAVEN_HOME" ~/.profile; then
  if grep -q 'export PATH=$MAVEN_HOME' ~/.profile; then
    echo -e "Environment variable added.\n"
  else
    echo -e "Something wrong with adding environment variable.\n"
    exit 1
  fi
fi
