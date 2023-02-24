if [ $# -lt 3 ]; then
  echo "Script needs three arguments to run"
  echo "Username as first argument"
  echo "User email as second argument"
  echo "Name to give to GitHub ssh key as third argument"
  exit 1
fi

sudo add-apt-repository -y ppa:git-core/ppa
sudo apt update
sudo apt install git -y

username=$1
email=$2
keyname=$3

git config --global user.name ${username}
git config --global user.email ${email}

ssh-keygen -t ed25519 -C ${email} -f /home/$USER/.ssh/${keyname}
eval "$(ssh-agent)"
ssh-add /home/$USER/.ssh/${keyname}

sudo apt install gh -y
gh auth login

#What account do you want to log into? GitHub.com
#What is your preferred protocol for Git operations? SSH
#Upload your SSH public key to your GitHub account? Skip
#How would you like to authenticate GitHub CLI? Login with a web browser

gh auth refresh -h github.com -s admin:public_key
gh ssh-key add /home/$USER/.ssh/${keyname}.pub -t ${keyname}

