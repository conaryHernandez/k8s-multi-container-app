docker build -t conaryh/multi-client:latest -t conaryh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t conaryh/multi-server:latest -t conaryh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t conaryh/multi-worker:latest -t conaryh/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push conaryh/multi-client:latest
docker push conaryh/multi-server:latest
docker push conaryh/multi-worker:latest

docker push conaryh/multi-client:$SHA
docker push conaryh/multi-server:$SHA
docker push conaryh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=conaryh/multi-server:$SHA
kubectl set image deployments/client-deployment client=conaryh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=conaryh/multi-worker:$SHA