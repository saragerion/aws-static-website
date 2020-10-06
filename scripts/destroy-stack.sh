#!/bin/bash

######################################################
#
# File ./scripts/destroy-stack.sh
# This script destroys the Terraform infrastructure on AWS
#
# How to use:
# - Make sure the file is executable  :   chmod +x ./scripts/destroy-stack.sh
# - Destroys all the changes          :   ./scripts/destroy-stack.sh apply
#

function main {
    ROOT_DIR=$(pwd)
    source "$ROOT_DIR/scripts/_setup.sh"

    setDeploymentConfig

    source "$ROOT_DIR/scripts/_terraform-steps.sh"

    cd "$ROOT_DIR/terraform/service"
    terraformDestroySteps "$@"
}

main "${*}"
