if [ $# -lt 1 ]; then
  echo "Script needs Scala version as argument to run"
  exit 1
fi

version=$1

wget https://github.com/lampepfl/dotty/releases/download/$version/scala3-$version.tar.gz

# [-f] Check if file exists
if [ -f *.tar.gz ]; then
  echo "Download completed"
else
  echo "File not downloaded"
  exit 1
fi

# [-x] Extract
# [-f] Specify the name of an archive file
# [-d] Check if directory exists
tar -xf scala*.tar.gz
if [ -d $PWD/scala*/ ]; then
  rm scala*.tar.gz
  echo "Extraction completed"
else
  echo "Extraction not performed"
  exit 1
fi

# [$(command)] Store the output in a variable
# [basename] Print the last element of a file path
# [$PWD] Print current absolute path
# [&&] Execute commands only if the preceding command was successfully executed
scalafolder=$(basename $PWD/scala*/) && echo $scalafolder

# [mkdir] Create directory
# [chmod] Change permissions
# [a+rwx] all, read write and execute
if [ ! -d /inst/ ]; then
  echo "/inst/ directory not found, creating it"
  sudo mkdir /inst/
  sudo chmod a+rwx /inst/
else
  echo "/inst/ directory found"
fi

# [rm] Remove files/directories
# [-r] And all its content
# [-f] Without asking
if [ -d /inst/$scalafolder ]; then
  echo "/inst/${scalafolder} folder already exists"
  sudo rm -rf /inst/$scalafolder
  echo "Already existing folder deleted"
fi

# [mv] Move file/directory from <path> to <path>
sudo mv scala*/ /inst/
if [ -d /inst/$scalafolder ]; then
  echo "Folder moved to /inst directory"
else
  echo "Folder not moved to /inst directory"
  exit 1
fi

# [grep] Print lines that match patterns
# [-q] Quiet do not write anything to standard output
# [sed] Transform text
# [-i] Edit same input file
# ['/pattern/d'] Delete lines that match the pattern
if grep -q "export SCALA_HOME" ~/.profile && grep -q 'export PATH=$SCALA_HOME' ~/.profile; then
  echo "Previous environment variables for Scala found"
  sed -i '/export SCALA_HOME.*/d' ~/.profile
  sed -i '/export PATH=$SCALA_HOME.*/d' ~/.profile
  echo "Previous environment variables for Scala deleted"
fi

sudo echo "" >> ~/.profile
sudo echo export SCALA_HOME=/inst/$scalafolder >> ~/.profile
sudo echo 'export PATH=$SCALA_HOME/bin:$PATH' >> ~/.profile
sudo echo "" >> ~/.profile
if grep -q "export SCALA_HOME" ~/.profile && grep -q 'export PATH=$SCALA_HOME' ~/.profile; then
  echo "Environment variable added"
else
  echo "Environment variable not added"
  exit 1
fi

echo "$scalafolder installed successfully"

