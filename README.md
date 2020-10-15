# aws-static-website

Simple static website built with Terraform, deployed to an AWS account of choice.

**Technologies**

- Terraform
- AWS (S3, CloudFront, CloudWatch)
- Bash
- HTML
- CSS
- JavaScript

**Prerequisites**

1. An AWS account;
2. The following **CLI software** installed and correctly configured in your local environment:
- [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform);
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html);
3. An S3 bucket already existing and located in your AWS account, where the Terraform state will be stored remotely;

## Usage

### Deploy the whole stack

```shell script
chmod +x ./scripts/deploy.sh
./scripts/deploy.sh
./scripts/deploy.sh apply
```

### Deploy frontend assets only

```shell script
chmod +x ./scripts/deploy-frontend-assets.sh
./scripts/deploy-frontend-assets.sh
```

### Deploy the terraform infra only

```shell script
chmod +x ./scripts/deploy-terraform.sh
./scripts/deploy-terraform.sh
./scripts/deploy-terraform.sh apply
```

### Destroy the entire stack

```shell script
chmod +x ./scripts/destroy-stack.sh
./scripts/destroy-stack.sh
```

### Run a small load test

```shell script
chmod +x ./scripts/load-test.sh
./scripts/oad-test.sh https://xxxxxxxxxxx.cloudfront.net/
```


## TODO
- Improve documentation;
- Create deployment pipelines using Github Actions;
