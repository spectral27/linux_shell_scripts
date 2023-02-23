version=2022.3.2
wget https://download.jetbrains.com/idea/ideaIC-${version}.tar.gz

tar -xf idea*.tar.gz
rm idea*.tar.gz

ijfolder=$(basename $PWD/idea*/)

if [ ! -d /inst/ ]; then
  echo -e "/inst/ directory not found, creating it\n"
  sudo mkdir /inst/
  sudo chmod a+rwx /inst/
else
  echo -e "/inst/ directory found\n"
fi

mv $ijfolder /inst/
/inst/$ijfolder/bin/idea.sh

