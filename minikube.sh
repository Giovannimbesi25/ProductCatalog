minikube start
kubectl apply -f deployments/mysql.yaml
kubectl apply -f deployments/product-frontend.yaml
kubectl apply -f deployments/product-backend.yaml