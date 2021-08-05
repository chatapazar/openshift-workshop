install web terminal operator

oc apply -f  manifests/cluster-monitoring-config.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: cluster-monitoring-config
  namespace: openshift-monitoring
data:
  config.yaml: |
    enableUserWorkload: true
    prometheusK8s: 
      volumeClaimTemplate:
       spec:
         storageClassName: gp2
         volumeMode: Filesystem
         resources:
           requests:
             storage: 50Gi

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

exit

oc rollout pause deployment/backend
oc set probe deployment/backend --readiness --get-url=http://:8080/q/health/ready --initial-delay-seconds=8 --failure-threshold=1 --period-seconds=3 --timeout-seconds=5
oc set probe deployment/backend --liveness --get-url=http://:8080/q/health/live --initial-delay-seconds=5 --failure-threshold=1 --period-seconds=10 --timeout-seconds=5
oc rollout resume deployment/backend
watch oc get pods 

POD=$(oc get pods --no-headers -l app=backend | grep backend |head -n 1| awk '{print $1}')
oc exec $POD -- curl -s http://localhost:8080/backend/stop

oc describe pod $POD

oc get pods --> show restart

POD=$(oc get pods --no-headers -l app=backend | grep backend |head -n 1| awk '{print $1}')
oc exec $POD -- curl -s http://localhost:8080/databasestatus/down

oc describe pod $POD

oc get pods --> show not ready
oc exec $POD -- curl -s http://localhost:8080/databasestatus/up
oc get pods --> show ready

remove health from gui menu

scale , manual, auto
manual scale to 2 from gui

BACKEND_URL=http://$(oc get route backend -o jsonpath='{.spec.host}')
while [  1  ];
do
    curl $BACKEND_URL/backend
    printf "\n"
    sleep 10
done

view log in pod and log console show output from 2 pod
sclae back to 0 pod
scale to 1 pod

auto scale
add resource limit

          resources: {}
to
          resources:
            requests:
              cpu: "0.1"
              memory: 256Mi
            limits:
              cpu: "0.2"
              memory: 512Mi

add autohorizental scaling min 1, max 3, cpu utilized 5%
BACKEND_URL=http://$(oc get route backend -o jsonpath='{.spec.host}')
while [  1  ];
do
    curl $BACKEND_URL/backend
    printf "\n"
done
wait until scale to 3
cancel load and wait until scale to 1 (5 minute)
remove autoscale and scale down to 1 manual (no wait)


user workload monitoring
test app metrics
oc project ademo
oc exec $(oc get pods -l app=backend | grep backend | head -n 1 | awk '{print $1}') \
-- curl -s  http://localhost:8080/q/metrics

oc exec $(oc get pods -l app=backend | grep backend | head -n 1 | awk '{print $1}') \
-- curl -s  http://localhost:8080/q/metrics/application

oc exec $(oc get pods -l app=backend | grep backend | head -n 1 | awk '{print $1}') \
-- curl -s  http://localhost:8080/backend

apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  labels:
    k8s-app: backend-monitor
  name: backend-monitor
spec:
  endpoints:
  - interval: 30s
    port: 8080-tcp
    path: /q/metrics
    scheme: http
  - interval: 30s
    port: 8080-tcp
    path: /q/metrics/application
    scheme: http
  selector:
    matchLabels:
      app: backend

monitor
oc adm policy add-role-to-user  monitoring-edit user1 -n project1
rate(application_org_acme_getting_started_BackendResource_countBackend_total[1m])


logging
https://docs.openshift.com/container-platform/4.7/logging/cluster-logging-deploying.html
login kibana
create index infra, app
discover with namespace:"ademo", containername:"backend"

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