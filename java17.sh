wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz
if [ -s *.tar.gz ]; then
  echo -e "Download completed.\n"
else
  echo -e "File not downloaded.\n"
  exit 1
fi

tar -xf jdk*.tar.gz
if [ -d $PWD/jdk*/ ]; then
  rm jdk*.tar.gz
  echo -e "Extraction completed.\n"
else
  echo -e "Extraction not performed.\n"
  exit 1
fi

jdkfolder=$(basename $PWD/jdk*/) && echo -e "$jdkfolder \n"

echo root | sudo -S cp -R jdk*/ /opt && sudo -S rm -R jdk*/ && echo -e "\n"
if [ -d /opt/$jdkfolder ]; then
  echo -e "Folder moved to /opt directory.\n"
else
  echo -e "Something wrong with moving the directory.\n"
  exit 1
fi

echo root | sudo -S echo "" >> ~/.profile
echo root | sudo -S echo export JAVA_HOME=/opt/$jdkfolder >> ~/.profile
echo root | sudo -S echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.profile
if grep -q "export JAVA_HOME" ~/.profile; then
  if grep -q 'export PATH=$JAVA_HOME' ~/.profile; then
    echo -e "Environment variable added.\n"
  else
    echo -e "Something wrong with adding environment variable.\n"
    exit 1
  fi
fi
