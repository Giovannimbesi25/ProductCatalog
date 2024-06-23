#!/bin/bash

# Trasferimento deployments
echo "Trasferimento dei file necessari..."
scp -i KeyEC2.pem -r deployments ubuntu@44.211.218.108:~ > /dev/null 2>&1

# Connessione alla macchina remota e esecuzione dei comandi
ssh -i KeyEC2.pem ubuntu@44.211.218.108 -t '
    # Comandi remoti da eseguire sul server remoto

    echo 'Installazione di kubectl...'
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl > /dev/null 2>&1
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl > /dev/null 2>&1

    echo 'Installazione di Docker...'
    sudo apt-get update -y > /dev/null 2>&1 && sudo apt-get install -y docker.io > /dev/null 2>&1
    sudo systemctl start docker > /dev/null 2>&1
    sudo systemctl enable docker > /dev/null 2>&1
    sudo usermod -a -G docker $(whoami) > /dev/null 2>&1

    sg docker -c "

      echo 'Installazione di Minikube...'
      curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 > /dev/null 2>&1
      chmod +x minikube
      sudo mv minikube /usr/local/bin/ > /dev/null 2>&1

      echo 'Avvio di Minikube...'
      minikube start --driver=docker > /dev/null 2>&1

      # Applica i deployment
      echo 'Applicazione dei deployment...'
      kubectl apply -f ~/deployments > /dev/null 2>&1
    "
    exec bash -l
'