#!/bin/bash

######################################################
#
# File ./scripts/deploy-terraform.sh
# This script deploys the Terraform infrastructure on AWS
#
# How to use:
# - Make sure the file is executable  :   chmod +x ./scripts/deploy-terraform.sh
# - Preview the Terraform changes     :   ./scripts/deploy-terraform.sh
# - Deploy all the changes            :   ./scripts/deploy-terraform.sh apply
#

function main {
    ROOT_DIR=$(pwd)
    source "$ROOT_DIR/scripts/_setup.sh"

    setDeploymentConfig
    introComments "$@"

    source "$ROOT_DIR/scripts/_terraform-steps.sh"

    cd "$ROOT_DIR/terraform/service"
    terraformSteps "$@"

    if [ ! "$1" = "apply" ]; then
        echo "Above you can see the planned changes. To apply those changes run './scripts/deploy-terraform.sh apply' "
    fi
}

main "${*}"