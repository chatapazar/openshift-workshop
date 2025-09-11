export USER_PASSWORD=dH4lNWBp08rLzybF
export ADMIN_PASSWORD=Tw6ussPBTTJvwtoS
export totalUsers=1

# install operator
# web terminal 
# user workload monitoring

oc apply -f ../manifests/cluster-monitoring-config.yml -n openshift-monitoring
oc get pod -n openshift-user-workload-monitoring

# serverless, create knative at knative-serving project
# cluster observability 
# loki, cluster logging 

S3_BUCKET=$(oc get configs.imageregistry.operator.openshift.io/cluster -o jsonpath='{.spec.storage.s3.bucket}' -n openshift-image-registry)
REGION=$(oc get configs.imageregistry.operator.openshift.io/cluster -o jsonpath='{.spec.storage.s3.region}' -n openshift-image-registry)
ACCESS_KEY_ID=$(oc get secret image-registry-private-configuration -o jsonpath='{.data.credentials}' -n openshift-image-registry|base64 -d|grep aws_access_key_id|awk -F'=' '{print $2}'|sed 's/^[ ]*//')
SECRET_ACCESS_KEY=$(oc get secret image-registry-private-configuration -o jsonpath='{.data.credentials}' -n openshift-image-registry|base64 -d|grep aws_secret_access_key|awk -F'=' '{print $2}'|sed 's/^[ ]*//')
ENDPOINT=$(echo "https://s3.$REGION.amazonaws.com")
DEFAULT_STORAGE_CLASS=$(oc get sc -A -o jsonpath='{.items[?(@.metadata.annotations.storageclass\.kubernetes\.io/is-default-class=="true")].metadata.name}')

cat ../manifests/logging-loki-instance.yaml \
|sed 's/S3_BUCKET/'$S3_BUCKET'/' \
|sed 's/REGION/'$REGION'/' \
|sed 's|ACCESS_KEY_ID|'$ACCESS_KEY_ID'|' \
|sed 's|SECRET_ACCESS_KEY|'$SECRET_ACCESS_KEY'|' \
|sed 's|ENDPOINT|'$ENDPOINT'|'\
|sed 's|DEFAULT_STORAGE_CLASS|'$DEFAULT_STORAGE_CLASS'|' \
|oc apply -f -


# https://docs.redhat.com/en/documentation/red_hat_openshift_logging/6.3/html/about_openshift_logging/quick-start#quickstart-viaq_quick-start

oc create sa collector -n openshift-logging
oc adm policy add-cluster-role-to-user logging-collector-logs-writer -z collector -n openshift-logging
oc adm policy add-cluster-role-to-user collect-application-logs -z collector -n openshift-logging
oc adm policy add-cluster-role-to-user collect-audit-logs -z collector -n openshift-logging
oc adm policy add-cluster-role-to-user collect-infrastructure-logs -z collector -n openshift-logging

oc apply -f ../manifests/ClusterLogForwarder.yaml

# create project test

oc new-project test

# deploy https://github.com/chatapazar/openshift-workshop.git , path /sample, app name: test