ssh-keygen -t rsa
kubectl create secret generic gitssh --from-file=ssh-privatekey=C:\Users\cronjev\githubssh --from-file=ssh-publickey=C:\Users\cronjev\githubssh.pub