#!/bin/bash

function checkBackendConfigFile {
    BACKEND_CONFIG_FILE="${ROOT_DIR}/terraform/config/${AWS_ACCOUNT_ID}/backend.hcl"
    if [ ! -f "$BACKEND_CONFIG_FILE" ]; then
        echo "====================="
        echo "ERROR! File $BACKEND_CONFIG_FILE not found, please create a backend file with the following content:"
        echo "region=[the AWS region where your dynamodb table and s3 bucket are located]"
        echo "bucket=[the name of the s3 bucket]"
        echo "dynamodb_table=[the name of the dynamodb table]"
        exit 1
    fi
}

function printConfig() {
    echo "====================="
    echo "TERRAFORM BACKEND CONFIG"
    echo "key=$BACKEND_BUCKET_KEY"
    cat "$BACKEND_CONFIG_FILE"
    echo "====================="
    echo "TERRAFORM WORKSPACE"
    terraform workspace show
    echo "====================="
    echo "TERRAFORM ENVIRONMENT VARIABLES"
    echo "TF_DATA_DIR=$TF_DATA_DIR"
}

function printInputVariables() {
    echo "====================="
    echo "TERRAFORM INPUT VARIABLES"
    echo "env=$ENV"
    echo "aws_region=$AWS_REGION"
    echo "github_repo=$GITHUB_REPO"
    echo "owner=$OWNER"
}

function terraformInit() {
    checkBackendConfigFile
    BACKEND_BUCKET_KEY="${GITHUB_REPO}/${ENV}/${AWS_REGION}/terraform.tfstate"
    export TF_DATA_DIR="./.terraform/$AWS_ACCOUNT_ID-$ENV-$AWS_REGION"
    terraform init \
        -input=false \
        -backend-config="key=$BACKEND_BUCKET_KEY" \
        -backend-config="$BACKEND_CONFIG_FILE"
}

function terraformValidate() {
    terraform validate
}

function terraformPlan() {
    terraform plan -var "env=$ENV" -var "aws_region=$AWS_REGION" -var "github_repo=$GITHUB_REPO" -var "owner=$OWNER"
}

function terraformApply() {
    terraform apply -auto-approve -var "env=$ENV" -var "aws_region=$AWS_REGION" -var "github_repo=$GITHUB_REPO" -var "owner=$OWNER"
}

function terraformDestroy() {
    terraform destroy -auto-approve -var "env=$ENV" -var "aws_region=$AWS_REGION" -var "github_repo=$GITHUB_REPO" -var "owner=$OWNER"
}

function getOutputs() {
    BUCKET_NAME=$(terraform output s3_bucket)
    CF_DISTRIBUTION=$(terraform output cloudfront_distribution)
    WEBSITE_DOMAIN=$(terraform output website_domain)
}

function terraformSteps() {
    terraformInit
    printConfig
    printInputVariables
    terraformValidate
    terraformPlan

    if [ "$1" = "apply" ]; then
        terraformApply
        getOutputs
    fi
}

function terraformDestroySteps() {
    terraformInit
    terraformValidate
    terraformDestroy
}
