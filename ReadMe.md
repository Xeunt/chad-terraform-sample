# Chad Terraform Sample 🚀

A sample Terraform project demonstrating modern Infrastructure as Code (IaC) practices on AWS using **Terraform**, **GitHub Actions**, and **GitHub OIDC Authentication**.

This repository is intended as a learning project and reference implementation for deploying AWS infrastructure without storing long-lived AWS access keys in GitHub.

---

## Features

- Infrastructure as Code using Terraform
- GitHub Actions CI/CD
- GitHub OIDC authentication to AWS
- IAM Role assumption via AWS STS
- Secure, keyless authentication
- Terraform formatting and validation
- Terraform Plan
- Terraform Apply (optional)

---

## Architecture

```text
Developer
    │
    │ git push
    ▼
GitHub Repository
    │
    ▼
GitHub Actions Workflow
    │
    │ Request OIDC Token
    ▼
GitHub OIDC Provider
    │
    │ AssumeRoleWithWebIdentity
    ▼
AWS STS
    │
    ▼
IAM Role
    │
    ▼
Terraform
    │
    ▼
AWS Resources
```

---

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       └── terraform.yml
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── versions.tf
└── README.md
```

---

## Prerequisites

- AWS Account
- Terraform 1.x
- GitHub Repository
- GitHub Actions enabled
- IAM OIDC Provider configured
- IAM Role for GitHub Actions

---

## AWS Setup

### 1. Create GitHub OIDC Provider

```
https://token.actions.githubusercontent.com
```

Audience

```
sts.amazonaws.com
```

---

### 2. Create IAM Role

Configure the trust relationship to allow GitHub Actions to assume the role.

Example condition:

```json
"token.actions.githubusercontent.com:sub": "repo:<github-user>/<repository>:ref:refs/heads/main"
```

Example:

```text
repo:Xeunt/chad-terraform-sample:ref:refs/heads/main
```

---

### 3. Grant IAM Permissions

Attach only the permissions Terraform requires.

Example:

- AmazonS3FullAccess
- AmazonEC2FullAccess

or preferably a least-privilege custom policy.

---

## GitHub Actions Permissions

The workflow requires:

```yaml
permissions:
  id-token: write
  contents: read
```

The `id-token: write` permission allows GitHub Actions to request an OpenID Connect (OIDC) token, which is exchanged with AWS Security Token Service (STS) for temporary credentials.

---

## Configure AWS Credentials

Example GitHub Actions step:

```yaml
- uses: aws-actions/configure-aws-credentials@v4
  with:
    role-to-assume: arn:aws:iam::<ACCOUNT_ID>:role/github-actions-role
    aws-region: ap-southeast-1
```

---

## Running Locally

Initialize Terraform

```bash
terraform init
```

Validate

```bash
terraform validate
```

Format

```bash
terraform fmt
```

Plan

```bash
terraform plan
```

Apply

```bash
terraform apply
```

Destroy

```bash
terraform destroy
```

---

## GitHub Workflow

The workflow performs:

- Checkout repository
- Configure AWS credentials using GitHub OIDC
- Initialize Terraform
- Validate Terraform configuration
- Generate Terraform Plan
- Apply infrastructure (optional)

---

## Security

This project intentionally avoids storing AWS Access Keys in GitHub Secrets.

Instead it uses:

- GitHub OpenID Connect (OIDC)
- AWS Security Token Service (STS)
- Temporary IAM credentials

Benefits include:

- No long-lived credentials
- Automatic credential rotation
- Least privilege access
- Improved security posture

---

## Troubleshooting

### AccessDenied when assuming role

Verify:

- IAM Trust Policy
- Repository name
- Branch name
- `sub` claim
- `aud` claim (`sts.amazonaws.com`)

---

### Missing id-token permission

Ensure your workflow contains:

```yaml
permissions:
  id-token: write
  contents: read
```

---

### Invalid Identity Token

Verify that:

- OIDC Provider exists in AWS
- Audience is `sts.amazonaws.com`
- Trust policy matches your GitHub repository

---

## Learning Objectives

This project demonstrates:

- Terraform fundamentals
- AWS IAM
- GitHub Actions
- OpenID Connect (OIDC)
- AWS STS
- Infrastructure as Code
- CI/CD for AWS

---

## References

- Terraform Documentation
- GitHub Actions Documentation
- AWS IAM OIDC Documentation
- AWS STS Documentation

---

## License

This repository is provided for educational purposes.

Feel free to fork, modify, and use it as a starting point for your own Terraform and AWS CI/CD projects.