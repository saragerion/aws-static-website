#!/bin/bash

######################################################
#
# File ./scripts/deploy-frontend-assets.sh
# This script deploys the frontend assets in the S3 bucket
#
# How to use:
# - Make sure the file is executable  :   chmod +x ./scripts/deploy-frontend-assets.sh
# - Deploy all the changes            :   ./scripts/deploy-frontend-assets.sh
#

function main {
    ROOT_DIR=$(pwd)
    source "$ROOT_DIR/scripts/_setup.sh"

    setDeploymentConfig
    introComments "apply"

    source "$ROOT_DIR/scripts/_terraform-steps.sh"
    cd "$ROOT_DIR/terraform/service"
    getOutputs

    source "$ROOT_DIR/scripts/_frontend-assets-steps.sh"
    cd "$ROOT_DIR" || exit
    frontendAssetsSteps "$@"
}

main "${*}"
