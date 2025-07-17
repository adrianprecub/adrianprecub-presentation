#!/bin/bash

# Usage function
usage() {
    echo "Usage: $0 <ECR_REGISTRY> <ECR_REPOSITORY> <IMAGE_TAG>"
    echo "Example: $0 123456789012.dkr.ecr.us-east-1.amazonaws.com ecr_repo_name imageTag"
    exit 1
}

# Check if all parameters are provided
if [ $# -ne 3 ]; then
    echo "Error: Missing required parameters"
    usage
fi

# Configuration from parameters
ECR_REGISTRY="$1"
ECR_REPOSITORY="$2"
IMAGE_TAG="$3"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting deployment to ECR...${NC}"
echo -e "${YELLOW}Registry: ${ECR_REGISTRY}${NC}"
echo -e "${YELLOW}Repository: ${ECR_REPOSITORY}${NC}"
echo -e "${YELLOW}Tag: ${IMAGE_TAG}${NC}"

# Check if AWS CLI is available
if ! command -v aws &> /dev/null; then
    echo -e "${RED}Error: AWS CLI is not installed${NC}"
    exit 1
fi

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo -e "${RED}Error: Docker is not running${NC}"
    exit 1
fi

# Step 1: Build the application
echo -e "${YELLOW}Step 1: Building application with Maven...${NC}"
mvn clean package -DskipTests
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Maven build failed${NC}"
    exit 1
fi

# Step 2: Build Docker image
echo -e "${YELLOW}Step 2: Building Docker image...${NC}"
docker build --platform linux/amd64 -t ${ECR_REPOSITORY}:${IMAGE_TAG} .
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Docker build failed${NC}"
    exit 1
fi

# Step 3: Login to ECR
echo -e "${YELLOW}Step 3: Logging into ECR...${NC}"
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ECR_REGISTRY}
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: ECR login failed${NC}"
    exit 1
fi

# Step 4: Tag image for ECR
echo -e "${YELLOW}Step 4: Tagging image for ECR...${NC}"
docker tag ${ECR_REPOSITORY}:${IMAGE_TAG} ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}

# Step 5: Push to ECR
echo -e "${YELLOW}Step 5: Pushing image to ECR...${NC}"
docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Successfully deployed to ECR!${NC}"
    echo -e "${GREEN}Image URI: ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}"
else
    echo -e "${RED}Error: Push to ECR failed${NC}"
    exit 1
fi