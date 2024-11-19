# Prerequisite for workshop (Instructor Only)

- OCP 4.16

## Install Operator

- Login wih Cluster Admin for Install Operator
- Red Hat Streams for Apache Kafka 2.2 channel, version 2.2.1-7 !!!
- Serverless (create knative-serving in project knative-serving)
- Web Terminal
- OpenShift Logging 5.9
- Loki 5.9

## Config Loki --> https://github.com/rhthsa/openshift-demo/blob/main/loki.md


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