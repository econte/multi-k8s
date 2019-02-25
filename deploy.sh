# compila as imagens
docker build -t econte/multi-client:latest -t econte/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t econte/multi-server:latest -t econte/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t econte/multi-worker:latest -t econte/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Envia as imagens para o docker hur
docker push econte/multi-client:latest
docker push econte/multi-server:latest
docker push econte/multi-worker:latest

docker push econte/multi-client:$SHA
docker push econte/multi-server:$SHA
docker push econte/multi-worker:$SHA

#aplica as configuracoes do kubernetes
kubectl apply -f k8s

#aplicar a ultima configuracao imperativamente
kubectl set image deployments/server-deployment server=econte/multi-server:$SHA
kubectl set image deployments/client-deployment client=econte/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=econte/multi-worker:$SHA