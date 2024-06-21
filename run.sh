#!/bin/bash

# Funzione per verificare l'esito dell'ultimo comando ed uscire in caso di errore
check_command_success() {
  if [ $? -ne 0 ]; then
    echo "Errore: il comando precedente non è riuscito."
    exit 1
  fi
}

# Installazione di kubectl
if ! command -v kubectl &> /dev/null; then
  echo "Installazione di kubectl..."
  curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
  chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
  check_command_success
else
  echo "kubectl è già installato."
fi

# Installazione di Docker
if ! command -v docker &> /dev/null; then
  echo "Installazione di Docker..."
  sudo apt-get update -y && sudo apt-get install -y docker.io
  check_command_success
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo usermod -a -G docker $(whoami)
  newgrp docker
else
  echo "Docker è già installato."
fi

# Installazione di Minikube
if ! command -v minikube &> /dev/null; then
  echo "Installazione di Minikube..."
  curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  chmod +x minikube
  sudo mv minikube /usr/local/bin/
  check_command_success
else
  echo "Minikube è già installato."
fi

# Avvio di Minikube
echo "Avvio di Minikube..."
minikube start --driver=docker
check_command_success

# Trasferimento deployments
echo "Trasferimento dei file necessari..."
scp -i KeyEC2.pem -r cloud_project/ansible/ ubuntu@<ip-addr>
check_command_success
scp -i KeyEC2.pem -r cloud_project/deployments/ ubuntu@<ip-addr>
check_command_success

# Apply Deployments
echo "Configurazione di Minikube e Kubernetes..."
minikube start
kubectl apply -f deployments/product-frontend.yaml
kubectl apply -f deployments/product-backend.yaml
nohup kubectl port-forward svc/product-backend-service 8080:8080 --address 0.0.0.0 &
nohup kubectl port-forward svc/product-frontend-service 3000:80 --address 0.0.0.0 &
check_command_success

echo "L'IP di Minikube è:"
minikube ip
check_command_success

echo "Script completato con successo."
