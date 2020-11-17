#!/bin/bash
TASK_FAMILY="kube-app-demo"
SERVICE_NAME="kube-app-svc"
CLUSTER_NAME="kube-app-cluster"

sed -e "s;%BUILD_NUMBER%;$IMAGE_TAG;g" taskdef.json > taskdef-${IMAGE_TAG}.json

aws ecs register-task-definition --family ${TASK_FAMILY} --cli-input-json file://taskdef-${IMAGE_TAG}.json  > /dev/null
 
TASK_REVISION=`aws ecs describe-task-definition --task-definition ${TASK_FAMILY} | egrep "revision" | tr "/" " " | awk '{print $2}' | sed 's/,//'`
 
DESIRED_COUNT=`aws ecs describe-services --cluster ${CLUSTER_NAME} --services ${SERVICE_NAME} | egrep "desiredCount" | tr "/" " " | awk '{print $2}'| sed 's/,//' | head -n 1`
 
if [[ ${DESIRED_COUNT} = "0" ]]; then
  
  DESIRED_COUNT="1"
 
fi
 
aws ecs update-service --cluster ${CLUSTER_NAME} --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --desired-count ${DESIRED_COUNT}
 
#rm deployment/task-definitions/production/sp-spinny-web-prod-task-v${BUILD_NUMBER}-${IMAGE_TYPE}.json

 
