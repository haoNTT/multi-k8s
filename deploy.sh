docker build -t htiian/multi-client:latest -t htiian/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t htiian/multi-server:latest -t htiian/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t htiian/multi-worker:latest -t htiian/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push htiian/multi-client:latest
docker push htiian/multi-client:$GIT_SHA
docker push htiian/multi-server:latest
docker push htiian/multi-server:$GIT_SHA
docker push htiian/multi-worker:latest
docker push htiian/multi-worker:$GIT_SHA

kubectl apply -f k8s # this is because we install kubectl in the by gcp
kubectl set image deployment/server-deployment server=htiian/multi-server:$GIT_SHA
kubectl set image deployment/client-deployment client=htiian/multi-client:$GIT_SHA
kubectl set image deployment/worker-deployment worker=htiian/multi-worker:$GIT_SHA