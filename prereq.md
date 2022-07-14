# Prerequisite for workshop (Instructor Only)
<!-- TOC -->

- [Prerequisite for workshop (Instructor Only)](#prerequisite-for-workshop-instructor-only)
  - [Install Operator](#install-operator)
  - [Create User](#create-user)
  - [Grant ServiceMonitor to User](#grant-servicemonitor-to-user)
  - [setup user workload monitoring](#setup-user-workload-monitoring)

<!-- /TOC -->
## Install Operator
- Web Terminal
- AMQ Streams
- Serverless (create knative-serving in project knative-serving)
- ElasticSearch
- ClusterLogging
  - required 3 node of worker
  - create clusterlogging instance
    ```yaml
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
                storageClassName: gp2
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
    ```
  - create index infra and app in kibana


## Create User
- run [setup_user.sh](bin/setup_user.sh)


## Grant ServiceMonitor to User
- run [setup_monitor.sh](bin/setup_monitor.sh)

## setup user workload monitoring
- install user workload monitoring
  https://github.com/rhthsa/openshift-demo/blob/main/application-metrics.md