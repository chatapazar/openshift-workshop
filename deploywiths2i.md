# Deploy java application (quarkus) to openshift with s2i
<!-- TOC -->

- [Deploy java application (quarkus) to openshift with s2i](#deploy-java-application-quarkus-to-openshift-with-s2i)
  - [Create Openshift Project](#create-openshift-project)
  - [Deploy java Application to Openshift with OpenShift Developer Console (S2I)](#deploy-java-application-to-openshift-with-openshift-developer-console-s2i)

<!-- /TOC -->

## Create Openshift Project
- open browser to https://console-openshift-console.apps.xxx.opentlc.com
  - confirm URL from instructor
- login to openshift with your username/password
  - username: 'userx'
  - password: openshift
  ![](images/work_1.png)
- select Developer Perspective from left menu (if openshift don't default page for you)
  ![](images/work_2.png)
- create project with your username such as 'user1'
  - go to dropdown at Project: All Projects
  - click Create Project
  ![](images/work_3.png)
  - set Name*= 'userx', Display Name = 'userx', Description = 'userx workshop'
  ![](images/work_4.png)
  - click create, openshift console will change page to new project
  ![](images/work_5.png)

## Deploy java Application to Openshift with OpenShift Developer Console (S2I)
- click +Add menu in left pane
- select From Git
  ![](images/work_6.png)
- in Import from Git page, input Git Repo URL with 'https://github.com/chatapazar/openshift-workshop.git'
- wait until Openshift validate URL complete (page will show validated complete icon)
  ![](images/work_7.png)
  - Optional: Not required for this lab! 
    
    you can input additional information for get source code such as
    - Git Reference: for branch, tag, or commit. (default s2i will checkout from default branch such as main or master)
    - Context dir: in case source code don't place in root of git such as /code
    - Source Secret: provide user/password for private repository
  ![](images/work_26.png)  
- OpenShift S2I will automatic select Builder Image from your source code, in case s2i can't detect base image. you can manual select.
- developer can select builder image versio from dropdown list such as java application can select base image for jdk8 or jdk11 
- for this workshop, Please select 'openjdk-11-ubi8'  or Red Hat OpenJDK 11 (UBI 8)
  ![](images/work_8.png)
- next, in general section set
  - Application name: backend
  - Name: backend
  - Resources: select Deployment (deployment for standard Kubernetes, DeploymentConfig is deployment with extension feature from OpenShift)
  - Advanced Options: checked Create a Route to the Application
  ![](images/work_9.png)
- before click create, in advanced option
  - click 'Labels' link
  ![](images/work_10.png)
  - add label 'app=backend'
  ![](images/work_11.png)
  - click 'Resource limits' link
  - set CPU
  ![](images/work_12.png)
- a
