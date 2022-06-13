wget https://download.jetbrains.com/idea/ideaIC-2022.1.2.tar.gz
tar -xf idea*.tar.gz
rm idea*.tar.gz
ijfolder=$(basename $PWD/idea*/)
mv $ijfolder ~
~/$ijfolder/bin/idea.sh
