kubectl apply -f deployments/product-frontend.yaml
kubectl apply -f deployments/product-backend.yaml
minikube addons enable ingress
kubectl apply -f deployments/ingress.yaml
minikube ip
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/cloud/deploy.yaml


# kubectl get pods --namespace ingress-nginx


