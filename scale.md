# Scaling up your application in order to handle workload
<!-- TOC -->

- [Scaling up your application in order to handle workload](#scaling-up-your-application-in-order-to-handle-workload)
  - [Prerequisite](#prerequisite)
  - [Manual Scale Application](#manual-scale-application)
  - [Auto Scale Application](#auto-scale-application)

<!-- /TOC -->
## Prerequisite
- Complete [Deploy application to openshift with s2i](deploywiths2i.md)
- Go to your project (same as your username)
- Open Web Terminal by click '>_' on top of OpenShift Web Console
- use web terminal to run command line

## Manual Scale Application
- click topology in left menu, click Duke icon (backend deployment), Details tab
- click increase ther pod count (^ icon) to 2 Pod

  ![](images/scale_1.png) 

- wait until application scale to 2 Pods (circle around Duke icon change to dark blue)

  ![](images/scale_2.png)

  ![](images/scale_3.png)

- Wait a few minutes, util new pod ready to receive request!!! 

- Test load to application, go to web terminal, run below command 
  ```bash
  BACKEND_URL=https://$(oc get route backend -o jsonpath='{.spec.host}')
  while [  1  ];
  do
    curl $BACKEND_URL/backend
    printf "\n"
    sleep 10
  done
  ```
  example result, check have result from 2 pods (Host value)
  ```bash
  Backend version:v1, Response:200, Host:backend-95647fbb8-kt886, Status:200, Message: Hello, World
  Backend version:v1, Response:200, Host:backend-95647fbb8-q9dqv, Status:200, Message: Hello, World
  Backend version:v1, Response:200, Host:backend-95647fbb8-kt886, Status:200, Message: Hello, World
  Backend version:v1, Response:200, Host:backend-95647fbb8-q9dqv, Status:200, Message: Hello, World
  ```

- after few minute, type 'ctrl-c' in web terminal to terminated curl command
- go to Resources Tab, in Pods section, show 2 pods after scale

  ![](images/scale_5.png)

- click 'View logs' of 1st Pod and 2nd Pod to confirm both pod are processed. 

  ![](images/scale_6.png)

  example of 1st pod

  ![](images/scale_7.png)  

  example of 2nd pod

  ![](images/scale_8.png)  

- back to detail pages of backend deployment, scale pod to 0 (for this case, no pod for this application)

  ![](images/scale_9.png)  

  ![](images/scale_10.png)  

- scale backend to 1 pod

  ![](images/scale_11.png) 
   
## Auto Scale Application
- Add HorizontalPodAutoscaler
- Go to Topology, click at Duke icon for open backend deployment, click action dropdown menu, select Add HorizontalPodAutoscaler
  ![](images/scale_12.png) 
- in Add HorizontalPodAutoscaler, use Form view
  - set Name: example
  - Minimum Pods: `1`
  - Maximum Pods: `3`
  - CPU Utilization: `10%`
  
  ![](images/scale_13.png) 

- click save, and wait until backend deployment change to Autoscaling

  ![](images/scale_14.png) 

- load test to backend application for proof auto scale
- go to web terminal
- run load test command

  ```bash
  BACKEND_URL=https://$(oc get route backend -o jsonpath='{.spec.host}')
  while [  1  ];
  do
    curl $BACKEND_URL/backend
    printf "\n"
  done
  ```

- click detail tab of backend deployment, wait until autoscaled to 3 (wait a few minutes)

  ![](images/scale_15.png)   

- click resources tab, see 3 pods auto scale

  ![](images/scale_16.png)

- click Observe tab to view CPU usage 

  ![](images/scale-99.png)

- back to web terminal, input 'ctrl-c' to terminate load test command
- wait 5 minute, autoscaled will reduce pod to 1. **(if you don't want to wait autoscale down to 1 pod, you can remove HorizontalPodAutoscaler and manual scale down to 1 by yourself.)**

  ![](images/scale_18.png)

- remove HorizontalPodAutoscaler, go to backend deployment information page, select action menu, select remove HorizontalPodAutoscaler

  ![](images/scale_19.png)      

- confirm Remove, and wait until backend change to manual scale

  ![](images/scale_20.png)  

  ![](images/scale_11.png) 

- **Optional: if you don't want to wait autoscale down to 1 pod, you can remove HorizontalPodAutoscaler and manual scale down to 1 by yourself.**
  



