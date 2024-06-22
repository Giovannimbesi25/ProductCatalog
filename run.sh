#!/bin/bash

# Trasferimento deployments
echo "Trasferimento dei file necessari..."
scp -i KeyEC2.pem -r deployments ubuntu@<ip-addr>:~

# Connessione alla macchina remota e esecuzione dei comandi
ssh -i KeyEC2.pem ubuntu@<ip-addr> -t '
  # Comandi remoti da eseguire sul server remoto

  # Installazione di kubectl se non è già installato
  if ! command -v kubectl &> /dev/null; then
    echo "Installazione di kubectl..."
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
  else
    echo "kubectl è già installato."
  fi

  # Installazione di Docker se non è installato
  if ! command -v docker &> /dev/null; then
    echo "Installazione di Docker..."
    sudo apt-get update -y && sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -a -G docker $(whoami)
    newgrp docker
  else
    echo "Docker è già installato."
  fi

  # Installazione di Minikube se non è già installato
  if ! command -v minikube &> /dev/null; then
    echo "Installazione di Minikube..."
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    chmod +x minikube
    sudo mv minikube /usr/local/bin/
  else
    echo "Minikube è già installato."
  fi

  # Avvio di Minikube
  echo "Avvio di Minikube..."
  minikube delete -p minikube
  docker system prune -a
  minikube start --driver=docker

  # Applica i deployment
  echo "Applicazione dei deployment su Minikube..."
  kubectl apply -f ~/deployments

  bash -l
'

