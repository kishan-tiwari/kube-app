#!/bin/bash
TASK_FAMILY="kube-app-demo"
SERVICE_NAME="kube-app-svc"
#NEW_DOCKER_IMAGE="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE_REPO_NAME:$IMAGE_TAG"
CLUSTER_NAME="kube-app"

#OLD_TASK_DEF=$(aws ecs describe-task-definition --task-definition $TASK_FAMILY --output json)
#NEW_TASK_DEF=$(echo $OLD_TASK_DEF | jq --arg NDI $NEW_DOCKER_IMAGE '.taskDefinition.containerDefinitions[0].image=$NDI')
#FINAL_TASK=$(echo $NEW_TASK_DEF | jq '.taskDefinition|{family: .family, volumes: .volumes, containerDefinitions: .containerDefinitions}')

#aws ecs register-task-definition --family $TASK_FAMILY --cli-input-json "$(echo $FINAL_TASK)" --memory 512 > /dev/null
#aws ecs update-service --service $SERVICE_NAME --task-definition $TASK_FAMILY --cluster $CLUSTER_NAME --profile obsdev



sed -e "s;%BUILD_NUMBER%;$IMAGE_TAG;g" taskdef.json > taskdef-${IMAGE_TAG}.json

aws ecs register-task-definition --family ${TASK_FAMILY} --cli-input-json file://taskdef-${IMAGE_TAG}.json
 
#TASK_REVISION=`aws ecs describe-task-definition --task-definition ${TASK_FAMILY} | egrep "revision" | tr "/" " " | awk '{print $2}' | sed 's/,//'`
 
#DESIRED_COUNT=`aws ecs describe-services --cluster ${CLUSTER_NAME} --services ${SERVICE_NAME} | egrep "desiredCount" | tr "/" " " | awk '{print $2}'| sed 's/,//' | head -n 1`
 
#if [ ${DESIRED_COUNT} = "0" ]; then
#DESIRED_COUNT="1"
 
#fi
 
#aws ecs update-service --cluster ${CLUSTER_NAME} --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --desired-count ${DESIRED_COUNT}
 
#rm deployment/task-definitions/production/sp-spinny-web-prod-task-v${BUILD_NUMBER}-${IMAGE_TYPE}.json

 
