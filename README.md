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
