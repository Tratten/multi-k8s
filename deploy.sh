docker build -t tratten/multi-client:latest -t tratten/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tratten/multi-server:latest -t tratten/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tratten/multi-worker:latest -t tratten/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tratten/multi-client:latest
docker push tratten/multi-server:latest
docker push tratten/multi-worker:latest

docker push tratten/multi-client:$SHA
docker push tratten/multi-server:$SHA
docker push tratten/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=tratten/multi-client:$SHA
kubectl set image deployments/server-deployment server=tratten/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=tratten/multi-worker:$SHA