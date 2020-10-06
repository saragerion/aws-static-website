#!/bin/bash

######################################################
#
# File ./scripts/deploy.sh
# This script deploys the Terraform infrastructure on AWS and the frontend assets in the S3 bucket
#
# How to use:
# - Make sure the file is executable  :   chmod +x ./scripts/deploy.sh
# - Preview the Terraform changes     :   ./scripts/deploy.sh
# - Deploy all the changes            :   ./scripts/deploy.sh apply
#

function main {
    ROOT_DIR=$(pwd)
    source "$ROOT_DIR/scripts/steps/setup.sh"

    setDeploymentConfig
    introComments "$@"

    source "$ROOT_DIR/scripts/steps/terraform-steps.sh"
    source "$ROOT_DIR/scripts/steps/frontend-assets-steps.sh"

    cd "$ROOT_DIR/terraform/service"
    terraformSteps "$@"

    if [ "$1" = "apply" ]; then
        cd "$ROOT_DIR"
        frontendAssetsSteps "$@"
    else
        echo "Above you can see the planned changes. To apply those changes run './scripts/deploy.sh apply' "
    fi
}

main "${*}"
