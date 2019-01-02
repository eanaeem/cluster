docker build -t eanaeem/multi-client:latest -t eanaeem/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eanaeem/multi-server:latest -t eanaeem/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eanaeem/multi-worker:latest -t eanaeem/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push eanaeem/multi-client:latest
docker push eanaeem/multi-server:latest
docker push eanaeem/multi-worker:latest

docker push eanaeem/multi-client:$SHA
docker push eanaeem/multi-server:$SHA
docker push eanaeem/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eanaeem/multi-server:$SHA
kubectl set image deployments/client-deployment client=eanaeem/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eanaeem/multi-worker:$SHA