if [ $# -lt 4 ]; then
  echo "Script needs four arguments to run"
  echo "1. git username"
  echo "2. git email"
  echo "3. github ssh key name"
  echo "4. docker ubuntu codename (e.g. jammy)"
  exit 1
fi

username=$1
email=$2
keyname=$3
codename=$4

# +---------------+
# | Git           |
# +---------------+
sh git.sh ${username} ${email} ${keyname}
returncode=$? && echo "${returncode}\n"

if [ ${returncode} -gt 0 ]; then
  echo "Git installation error"
  exit 1
fi

echo "== Git installed ==\n"

# +---------------+
# | Docker        |
# +---------------+
sh docker.sh ${codename}
returncode=$? && echo "${returncode}\n"

if [ ${returncode} -gt 0 ]; then
  echo "Docker installation error"
  exit 1
fi

echo "== Docker installed ==\n"

# +---------------+
# | Minikube      |
# +---------------+
sh minikube.sh
returncode=$? && echo "${returncode}\n"

if [ ${returncode} -gt 0 ]; then
  echo "Minikube installation error"
  exit 1
fi

echo "== Minikube installed ==\n"

# +---------------+
# | kubectl       |
# +---------------+
sh kubectl.sh
returncode=$? && echo "${returncode}\n"

if [ ${returncode} -gt 0 ]; then
  echo "kubectl installation error"
  exit 1
fi

echo "== kubectl installed ==\n"

