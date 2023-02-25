#Java
sh java17.sh
returncode=$? && echo "${returncode}\n"

if [ ${returncode} -gt 0 ]; then
  echo "Java installation error"
  exit 1
fi

#Gradle
sh gradle.sh
returncode=$? && echo -e "${returncode}\n"

if [ ${returncode} -gt 0 ]; then
  echo "Gradle installation error\n"
  exit 1
fi

#Maven
sh maven3.sh
returncode=$? && echo -e "${returncode}\n"

if [ ${returncode} -gt 0 ]; then
  echo "Gradle installation error\n"
  exit 1
fi


