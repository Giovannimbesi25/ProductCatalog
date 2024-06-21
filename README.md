# Product Catalog
Questo progetto è stato sviluppato con l’obiettivo di creare un sistema efficiente e scalabile per la gestione di un catalogo di prodotti.

## Logica Implementativa
L’applicativo sviluppato è composto da due componenti principali: il frontend implementato in React e il backend
realizzato con Spring Boot. 

## Architettura

Il progetto utilizza Kubernetes per offrire un ambiente scalabile e gestibile per i microservizi frontend e backend. Il cluster Kubernetes è stato creato mediante l’utilizzo di Minikube, una soluzione leggera per eseguire un singolo cluster Kubernetes su una macchina locale, e viene gestito attraverso l’interfaccia della riga di comando kubectl. 

## Amazon Web Services(AWS)

Il progetto prevede l'utilizzo diversi servizi offerti da Amazon Web Services (AWS) per fornire un ambiente scalabile e affidabile per l’esecuzione e la gestione dei suoi componenti. 


## CI|CD

Il processo di Continuous Integration (CI) e Continuous Deployment (CD) è gestito utilizzando GitHub Actions e Ansible. Questo permette di automatizzare la build delle immagini Docker e il deployment del software all’interno del cluster Kubernetes su AWS.


## How To

Questo progetto include uno script bash `run.sh` che facilita l'installazione e la configurazione di un cluster Minikube su una macchina remota. Lo script gestisce l'installazione di Kubectl, Docker, e Minikube, oltre a trasferire i file necessari per applicare i deployment Kubernetes.

### Prerequisiti

- Accesso SSH alla macchina di destinazione con una chiave PEM (es. `KeyEC2.pem`).
- Una connessione internet attiva sulla macchina di destinazione.
- Si suppone che la macchina di destinazione sia basata su una distribuzione Linux Ubuntu, ma è possibile adattarlo in qualsiasi ambiente.

### Utilizzo

1. **Copia dello Script sulla Macchina di Destinazione**

   Prima di tutto, copia lo script run.sh sulla macchina di destinazione. Puoi farlo utilizzando scp:

   ```sh
   scp -i KeyEC2.pem setup_minikube.sh ubuntu@<ip-addr>:~

   ```


2. **Copia file di deploy**
   ```
   scp -i KeyEC2.pem -r cloud_project/ansible/ ubuntu@<ip-addr>:~
   scp -i KeyEC2.pem -r cloud_project/deployments/ ubuntu@<ip-addr>:~
   ```

2. **Esecuzione dello Script**
   Connettiti alla macchina di destinazione via SSH ed esegui lo script.

   ```
   ssh -i KeyEC2.pem ubuntu@<ip-addr>
   chmod +x run.sh
   ./run.sh
   ```

Lo script si occupa di verificare e, nel caso, installare kubectl, Docker e Minikube. Successivamente applica i file di deployment Kubernetes per configurare i servizi product-frontend e product-backend, esponendoli in modo da poterli contattare dall'esterno. Infine, mostra l'indirizzo IP del cluster tramite cui è possibile raggiungere la web app con un qualsiasi browser.

### Nota 
Sostituire <ip-addr> con l'indirizzo IP della macchina di destinazione del deploy.