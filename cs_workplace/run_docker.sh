#!/bin/bash -x

DOCKER_CMD="$(basename $0)"
WORKSPACE_DIR=$(dirname $0)
SCRIPT_DIR="${WORKSPACE_DIR}/scripts"
DOCKER_IMG="cs-workplace"
. $SCRIPT_DIR/get_aws_keys.sh $AWS_PROFILE


###
# terraform
###
if [ ! -z "(echo $DOCKER_CMD|grep terraform)" ]
then
    TERRORFORM_DIR=$(pwd)
    # load dev-terroform,prod-terraform,logs-terraform
    if [ ! -z "$(echo $DOCKER_CMD|grep "dev\|prod\|logs")" ]
    then
        DEV_TERRAFORM='-var-file=environments/development/terraform.tfvars environments/development'
        PROD_TERRAFORM="-var-file=environments/production/terraform.tfvars environments/production"
        LOGS_TERRAFORM="-var-file=environments/logs/terraform.tfvars environments/logs"
        # check environment setup
        if [ -f ${TERRORFORM_DIR}/.terraform/environment ];
        then
            if [  ${AWS_PROFILE} = "dev" ]
            then
                echo "development" > ${TERRORFORM_DIR}/.terraform/environment
                DOCKER_CMD="terraform $@ ${DEV_TERRAFORM}"
            fi
            if [ ${AWS_PROFILE} = "prod" ]
            then
                echo "production" > ${TERRORFORM_DIR}/.terraform/environment
                DOCKER_CMD="terraform $@ ${PROD_TERRAFORM}"
            fi
            if [ ${AWS_PROFILE} = "logs" ]
            then
                echo "logs" > ${TERRORFORM_DIR}/.terraform/environment
                DOCKER_CMD="terraform $@ ${LOGS_TERRAFORM}"
            fi
        else
            echo "      "
            echo "Warning: Cannot file terraform environment"
            echo "Run following command to init the environment"
            echo "terraform get -update environments/development"
            echo "terraform get -update environments/logs"
            echo "terraform get -update environments/production"
            echo "terraform init environments/development"
            echo "terraform init environments/logs"
            echo "terraform init environments/production"
            echo "      "
            echo "terraform workspace select development"
            
            DOCKER_CMD="$DOCKER_CMD $@"
        fi
    else
        DOCKER_CMD="$DOCKER_CMD $@"
    fi
else
    DOCKER_CMD="$DOCKER_CMD $@"
fi

###
# main cmd
###
# echo "$@"
docker run -it --rm \
-v $(pwd):${HOME}/work_dir \
-v "${HOME}/.aws:$HOME/.aws" \
-v "${HOME}/.ssh:$HOME/.ssh" \
-v "${HOME}/vaultpass:$HOME/vaultpass" \
-v "${SSH_AUTH_SOCK}:/ssh-agent" \
-e "SSH_AUTH_SOCK=/ssh-agent" \
-e "AWS_PROFILE=${AWS_PROFILE}" \
-e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" \
-e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" \
-w ${HOME}/work_dir/ \
--log-driver none \
-u $USER \
${DOCKER_IMG} $DOCKER_CMD
#   		# cs-workplace sh
