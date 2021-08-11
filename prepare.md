grant servicemonitor

oc adm policy add-role-to-user monitoring-edit user1 -n user1
oc adm policy add-role-to-user monitoring-edit user2 -n user2
oc adm policy add-role-to-user monitoring-edit user3 -n user3

install web terminal operator

install user workload monitoring
https://github.com/rhthsa/openshift-demo/blob/main/application-metrics.md

create worker to 3 node
logging
https://docs.openshift.com/container-platform/4.7/logging/cluster-logging-deploying.html

apiVersion: "logging.openshift.io/v1"
kind: "ClusterLogging"
metadata:
  name: "instance" 
  namespace: "openshift-logging"
spec:
  managementState: "Managed"  
  logStore:
    type: "elasticsearch"  
    retentionPolicy: 
      application:
        maxAge: 1d
      infra:
        maxAge: 1d
      audit:
        maxAge: 1d
    elasticsearch:
      nodeCount: 3 
      storage:
        storageClassName: gp2
        size: 100G
      resources: 
        requests:
          memory: "8Gi"
      proxy: 
        resources:
          limits:
            memory: 256Mi
          requests:
             memory: 256Mi
      redundancyPolicy: "SingleRedundancy"
  visualization:
    type: "kibana"  
    kibana:
      replicas: 1
  collection:
    logs:
      type: "fluentd"  
      fluentd: {}

