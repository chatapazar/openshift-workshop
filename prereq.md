# Prerequisite for workshop (Instructor Only)

## Install Operator

- Login wih Cluster Admin for Install Operator
- Red Hat Streams for Apache Kafka 2.2 channel, version 2.2.1-7 !!!
- Serverless (create knative-serving in project knative-serving)
- Web Terminal
- ElasticSearch
- OpenShift Logging 5.9

## Config Cluster Logging (EFK)

  - required 3 node of worker
  - change storageClassName to your storage in cluster
  - create clusterlogging instance
    
```yaml
apiVersion: logging.openshift.io/v1
kind: ClusterLogging
metadata:
  name: instance 
  namespace: openshift-logging
spec:
  managementState: Managed 
  logStore:
    type: elasticsearch 
    retentionPolicy: 
      application:
        maxAge: 1d
      infra:
        maxAge: 7d
      audit:
        maxAge: 7d
    elasticsearch:
      nodeCount: 3 
      storage:
        storageClassName: <storage_class_name> 
        size: 200G
      resources: 
          limits:
            memory: 16Gi
          requests:
            memory: 16Gi
      proxy: 
        resources:
          limits:
            memory: 256Mi
          requests:
            memory: 256Mi
      redundancyPolicy: SingleRedundancy
  visualization:
    type: kibana 
    kibana:
      replicas: 1
  collection:
    type: fluentd 
    fluentd: {}
```

  - create index infra and app in kibana


## Create User
- run [setup_user.sh](bin/setup_user.sh)


## Grant ServiceMonitor to User
- run [setup_monitor.sh](bin/setup_monitor.sh)

## setup user workload monitoring
- run and check
  ```sh
  oc apply -f user-workload-monitoring.yaml
  oc get po -n openshift-user-workload-monitoring
  ```