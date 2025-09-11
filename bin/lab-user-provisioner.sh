#!/bin/bash

####################################################
# Functions
####################################################
repeat() {
    echo
    for i in {1..120}; do
        echo -n "$1"
    done
    echo
}

create_projects() {
    echo

    for i in $( seq 1 $totalUsers )
    do
         echo ""
         echo "Logging in as user$i user to create projects..."user
         echo

         oc login -u user$i -p $USER_PASSWORD --insecure-skip-tls-verify
         oc new-project user$i
    done

    oc login -u admin -p $ADMIN_PASSWORD --insecure-skip-tls-verify

    for i in $( seq 1 $totalUsers )
    do    
        oc adm policy add-role-to-user view user$i -n test
        oc adm policy add-role-to-user monitoring-edit user$i -n user$i
        oc adm policy add-role-to-user monitoring-rules-edit user$i -n user$i
        #oc -n openshift-user-workload-monitoring adm policy add-role-to-user user-workload-monitoring-config-edit user$i --role-namespace openshift-user-workload-monitoring
        oc adm policy add-role-to-user cluster-monitoring-view user$i -n user$i
        oc adm policy add-role-to-user cluster-monitoring-view user$i -n openshift-monitoring
        cat ../manifests/logging-view.yaml | sed "s#NAMESPACE#user$i#g" | sed "s#USERNAME#user$i#g" | oc apply -n user$i -f -
                
        repeat '-'
    done
}


####################################################
# Main (Entry point)
####################################################
totalUsers=$1

create_projects
repeat '-'

oc login -u admin -p $ADMIN_PASSWORD --insecure-skip-tls-verify
oc project default

echo "Done!!!"