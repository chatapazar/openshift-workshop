install web terminal

s2i --> from github

deployment, service, pod, route, buildconfig/build, imagestream
environment variable, configmag, secret
app.backend 
app.backend.200=https://httpbin.org/status/200
app.backend.400=https://httpbin.org/status/400
app.secretMessage=chatchai kongmanee

add storage
cd /data
echo 'This is a test' > data.txt
cd /opt
echo 'This is a test' > data.txt
scale down, scale up review file data.txt again
remove volume --> deployment page

health readiness/liveness
readiness
http://<route>/q/health/ready

liveness
http://<route>/q/health/live

ีuser web terminal

oc project <>
POD=$(oc get pods --no-headers -l app=backend | grep backend |head -n 1| awk '{print $1}')
oc rsh $POD
curl http://localhost:8080/q/health/live
curl http://localhost:8080/backend/stop
curl http://localhost:8080/q/health/live
curl http://localhost:8080/backend/start
curl http://localhost:8080/q/health/live

curl http://localhost:8080/q/health/ready
curl http://localhsot:8080/databasestatus/down
curl http://localhost:8080/q/health/ready
curl http://localhost:8080/databasestatus/up
curl http://localhost:8080/q/health/ready

oc rollout pause deployment/backend
oc set probe deployment/backend --readiness --get-url=http://:8080/q/health/ready --initial-delay-seconds=8 --failure-threshold=1 --period-seconds=3 --timeout-seconds=5
oc set probe deployment/backend --liveness --get-url=http://:8080/q/health/live --initial-delay-seconds=5 --failure-threshold=1 --period-seconds=10 --timeout-seconds=5
oc rollout resume deployment/backend
watch oc get pods -n project1


scale , manual, auto

logging

user workload monitoring

agenda
- introduction to openshift for developer (45 minutes)
- break (15 minutes)
- Lab (2 hours)
  - Deploy java application (quarkus) to openshift with s2i
  - Openshift Topology (deployment, service, route, pod, etc.)
  - application health check
  - environment variable, configmap, secret, pv
  - scale applicaiton with openshift
  - application logging
  - application monitoring