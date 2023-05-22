setup_user.sh

grant servicemonitor

setup_monitor.sh

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
        maxAge: 3d
      infra:
        maxAge: 3d
      audit:
        maxAge: 3d
    elasticsearch:
      nodeCount: 3 
      storage:
        storageClassName: gp3-csi
        size: 200G
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

create index infra and app in kibana
- web terminal
- amq streams
- serverless


    Remark: Role `monitoring-rules-view` is required for view `PrometheusRule` resource and role `monitoring-rules-edit` is required to  create, modify, and deleting `PrometheusRule` 
  
  Following example is granting role monitoring-rules-view and monitoring-rules-edit to user1 for project1

  ```bash
  oc adm policy add-role-to-user  monitoring-rules-view user1 -n project1
  oc adm policy add-role-to-user  monitoring-rules-edit user1 -n project1

  ``` 

  - knative-serving
  - elastic search
  - cluster logging