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

Questo progetto include uno script bash `run.sh` che facilita l'installazione e la configurazione di un cluster Minikube su una macchina remota, ed avvia i servizi di frontend e backend. Lo script gestisce l'installazione di Kubectl, Docker, e Minikube, oltre a trasferire i file necessari per applicare i deployment Kubernetes.

### Prerequisiti

- Assicurati di avere ssh installato.
- Una chiave come `KeyEC2.pem` che permetta la connessione alla macchina remota e che si trovi nella stessa cartella in cui è presente il progetto. 
- L'indirizzo IPv4 della macchina remota.

### Utilizzo

1. **Scarica il progetto**

   ```sh
   git clone https://github.com/Giovannimbesi25/cloud_project.git
   ```

2. **Posizionati sulla cartella del progetto**
   ```
   cd cloud_project
   ```

2. **Esecuzione dello Script**

   ```
   chmod +x run.sh
   ./run.sh
   ```

Lo script si occupa di verificare e, nel caso, installare kubectl, Docker e Minikube. Successivamente applica i file di deployment Kubernetes per configurare i servizi product-frontend e product-backend, esponendoli in modo da poterli contattare dall'esterno. 

Terminato lo script sarà possibile raggiungere la web app con un qualsiasi browser, inserendo come URL l'indirizzo ip pubblico della macchina remota con porta `:3000`.




### Note
Sostituire nel progetto `<ip-addr>` con l'indirizzo IP della macchina di destinazione del deploy.

Si suppone che la macchina remota sia basata su una distribuzione Linux Ubuntu, ma è possibile adattarlo in qualsiasi ambiente.

Abilitare la chiave .pem per la connessione remota (`chmod 400 KeyEC2.pem`) 