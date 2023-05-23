# [wget url] Download file
wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz

# [-f] Check if file exists
if [ -f *.tar.gz ]; then
  echo "Download completed\n"
else
  echo "File not downloaded\n"
  exit 1
fi

# [-x] Extract
# [-f] Specify the name of an archive file
# [-d] Check if directory exists
tar -xf jdk*.tar.gz
if [ -d $PWD/jdk*/ ]; then
  rm jdk*.tar.gz
  echo "Extraction completed\n"
else
  echo "Extraction not performed\n"
  exit 1
fi

# [$(command)] Store the output in a variable
# [basename] Print the last element of a file path
# [$PWD] Print current absolute path
# [&&] Execute commands only if the preceding command was successfully executed
jdkfolder=$(basename $PWD/jdk*/) && echo "$jdkfolder\n"

# [mkdir] Create directory
# [chmod] Change permissions
# [a+rwx] all, read write and execute
if [ ! -d /inst/ ]; then
  echo -e "/inst/ directory not found, creating it\n"
  sudo mkdir /inst/
  sudo chmod a+rwx /inst/
else
  echo -e "/inst/ directory found\n"
fi

# [rm] Remove files/directories
# [-r] And all its content
# [-f] Without asking
if [ -d /inst/$jdkfolder ]; then
  echo -e "/inst/${jdkfolder} folder already exists\n"
  sudo rm -rf /inst/$jdkfolder
  echo -e "Already existing folder deleted\n"
fi

# [mv] Move file/directory from <path> to <path>
sudo mv jdk*/ /inst/
if [ -d /inst/$jdkfolder ]; then
  echo -e "Folder moved to /inst directory\n"
else
  echo -e "Folder not moved to /inst directory\n"
  exit 1
fi

# [grep] Print lines that match patterns
# [-q] Quiet do not write anything to standard output
# [sed] Transform text
# [-i] Edit same input file
# ['/pattern/d'] Delete lines that match the pattern
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

