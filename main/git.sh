if [ $# -lt 3 ]; then
  echo "Script needs three arguments:"
  echo "1. username"
  echo "2. email"
  echo "3. ssh key name"
  exit 1
fi

sudo add-apt-repository -y ppa:git-core/ppa
sudo apt update
sudo apt install git -y

username=$1
email=$2
sshkeyname=$3

git config --global user.name $username
git config --global user.email $email

if [ -f /home/$USER/.ssh/$sshkeyname ]; then
  echo "Key already exists, deleting key\n"
  rm /home/$USER/.ssh/$sshkeyname
  rm /home/$USER/.ssh/$sshkeyname.pub
fi

ssh-keygen -t ed25519 -C $email -f /home/$USER/.ssh/$sshkeyname
eval "$(ssh-agent -s)"
ssh-add /home/$USER/.ssh/$sshkeyname

echo "Host github.com" >> ~/.ssh/config
echo "  IdentityFile ~/.ssh/${sshkeyname}" >> ~/.ssh/config

echo "Login into GitHub, create new ssh key and copy content of ${sshkeyname}"
