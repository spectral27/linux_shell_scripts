echo root | sudo -S add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git -y

git config --global user.name "spectre2727"
git config --global user.email "gsoldano27@aol.com"

ssh-keygen -t ed25519 -C "gsoldano27@aol.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

sudo apt install gh -y
gh auth login
gh auth refresh -h github.com -s admin:public_key
gh ssh-key add ~/.ssh/id_ed25519.pub -t "n56vv"
