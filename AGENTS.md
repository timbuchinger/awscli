# AGENTS.md

## Repository Overview

This repository provides a Docker image for the AWS Command Line Interface (AWS CLI). It packages the official AWS CLI tool in a lightweight Alpine Linux container for easy deployment and usage.

## Repository Structure

```
.
├── Dockerfile          # Docker image definition
├── requirements.txt    # Python package dependencies (awscli version)
├── README.md          # User-facing documentation
└── .github/
    └── workflows/
        ├── ci.yaml         # Continuous Integration workflow
        └── release.yaml    # Release and Docker Hub publishing workflow
```

## Purpose

This repository serves to:
- Provide a containerized version of AWS CLI for consistent cross-platform usage
- Maintain a specific version of AWS CLI (currently v1.27.114)
- Automate building and publishing Docker images to Docker Hub
- Enable easy distribution via `docker pull timbuchinger/awscli`

## Key Components

### Dockerfile
- **Base Image**: Alpine Linux 3.17 (lightweight)
- **Python Environment**: Python 3 with pip
- **AWS CLI Installation**: Installed via pip from requirements.txt
- **Verification**: Runs `aws --version` to verify installation

### Requirements
- Single dependency: `awscli==1.27.114`
- Pinned to specific version for reproducibility

### CI/CD Workflows

#### CI Workflow (`ci.yaml`)
- **Trigger**: On every push and manual workflow dispatch
- **Purpose**: Build and validate Docker image
- **Actions**:
  - Checkout code
  - Set up QEMU for multi-platform builds
  - Set up Docker Buildx
  - Build Docker image (without pushing)

#### Release Workflow (`release.yaml`)
- **Trigger**: On version tags (v*.*.* pattern) and manual dispatch
- **Purpose**: Build and publish Docker images to Docker Hub
- **Actions**:
  - Checkout code
  - Set up QEMU and Docker Buildx
  - Login to Docker Hub using secrets
  - Extract tag name from Git reference
  - Build and push images with tags:
    - Version-specific tag (e.g., `timbuchinger/awscli:v1.27.114`)
    - Latest tag (`timbuchinger/awscli:latest`)
  - Output image digest for verification

## Usage

Users can pull and use the Docker image with:

```bash
docker pull timbuchinger/awscli:latest
```

Or a specific version:

```bash
docker pull timbuchinger/awscli:v1.27.114
```

## Development Workflow

1. **Update AWS CLI Version**: Modify `requirements.txt` with the desired awscli version
2. **Test Locally**: Build the Docker image locally to verify
3. **Push Changes**: Commit and push changes (triggers CI workflow)
4. **Create Release**: Tag with semantic version (e.g., `v1.27.115`) to trigger release workflow
5. **Publish**: Release workflow automatically publishes to Docker Hub

## Maintenance Notes

- AWS CLI version is pinned in `requirements.txt`
- Docker image uses Alpine Linux for minimal size
- All Python dependencies are cleaned up after installation to reduce image size
- Requires Docker Hub credentials configured as repository secrets:
  - `DOCKERHUB_USERNAME`
  - `DOCKERHUB_TOKEN`
