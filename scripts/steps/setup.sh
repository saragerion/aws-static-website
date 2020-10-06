#!/bin/bash

function introComments() {
    echo "Getting started..."
    if [ "$1" = "apply" ]; then
        echo "Changes will be applied"
    else
        echo "Changes will not be applied, only visualized"
    fi
}

function getUserInput() {
    read -r -p "Enter the name of the current environment [dev]: " ENV
    ENV=${ENV:-dev}
    read -r -p "Enter the name of the AWS region where you want to deploy [eu-central-1]: " AWS_REGION
    AWS_REGION=${AWS_REGION:-"eu-central-1"}
    read -r -p "Enter the name of the current repository, *including* the owner [saragerion/aws-static-website]: " GITHUB_REPO
    GITHUB_REPO=${GITHUB_REPO:-saragerion/aws-static-website}
    read -r -p "Enter the name of the owner of this website, like your name or the name of your team [$(git config user.name)]: " OWNER
    OWNER=${OWNER:-$(git config user.name)}
}

function setDeploymentConfig() {
    TIMESTAMP=$(date +%s)

    getUserInput

    AWS_ACCOUNT_ID=$(aws sts get-caller-identity --output text --query 'Account')
}
