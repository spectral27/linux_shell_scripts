wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

if [ -s minikube-linux-amd64 ]; then
  echo "Download completed\n"
else
  echo "File not downloaded\n"
  exit 1
fi 

sudo install minikube-linux-amd64 /usr/local/bin/minikube

rm minikube-linux-amd64
