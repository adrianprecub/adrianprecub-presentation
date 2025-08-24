#!/bin/bash

# Usage function
usage() {
    echo "Usage: $0 <ECR_REGISTRY> <ECR_REPOSITORY> <IMAGE_TAG> [APP_RUNNER_SERVICE_ARN]"
    echo "Example: $0 123456789012.dkr.ecr.us-east-1.amazonaws.com ecr_repo_name imageTag"
    echo "Example with App Runner: $0 123456789012.dkr.ecr.us-east-1.amazonaws.com ecr_repo_name imageTag arn:aws:apprunner:us-east-1:123456789012:service/my-service/abc123"
    exit 1
}

# Check if minimum parameters are provided
if [ $# -lt 3 ] || [ $# -gt 4 ]; then
    echo "Error: Invalid number of parameters"
    usage
fi

# Configuration from parameters
ECR_REGISTRY="$1"
ECR_REPOSITORY="$2"
IMAGE_TAG="$3"
APP_RUNNER_SERVICE_ARN="$4"

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
    echo -e "${GREEN}Image URI: ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}${NC}"
    
    # Step 6: Update App Runner service if ARN provided
    if [ -n "$APP_RUNNER_SERVICE_ARN" ]; then
        echo -e "${YELLOW}Step 6: Updating App Runner service...${NC}"
        
        # Check if jq is available
        if ! command -v jq &> /dev/null; then
            echo -e "${RED}Error: jq is required for App Runner updates but is not installed${NC}"
            echo -e "${YELLOW}ECR deployment completed successfully, but App Runner update skipped${NC}"
            exit 0
        fi
        
        # Get current service configuration
        echo -e "${YELLOW}Getting current service configuration...${NC}"
        SERVICE_CONFIG=$(aws apprunner describe-service --service-arn "${APP_RUNNER_SERVICE_ARN}" --query 'Service.SourceConfiguration' --output json)
        if [ $? -ne 0 ]; then
            echo -e "${RED}Error: Failed to get App Runner service configuration${NC}"
            echo -e "${YELLOW}ECR deployment completed successfully, but App Runner update failed${NC}"
            exit 1
        fi
        
        # Update the image repository with new tag
        UPDATED_CONFIG=$(echo "$SERVICE_CONFIG" | jq --arg image_uri "${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}" '.ImageRepository.ImageIdentifier = $image_uri')
        
        # Update the App Runner service
        echo -e "${YELLOW}Applying configuration update to App Runner service...${NC}"
        aws apprunner update-service \
            --service-arn "${APP_RUNNER_SERVICE_ARN}" \
            --source-configuration "$UPDATED_CONFIG" \
            --output table
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Successfully updated App Runner service!${NC}"
            echo -e "${YELLOW}The service is now updating to use image: ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}${NC}"
        else
            echo -e "${RED}Error: Failed to update App Runner service${NC}"
            echo -e "${YELLOW}ECR deployment completed successfully, but App Runner update failed${NC}"
            exit 1
        fi
    else
        echo -e "${YELLOW}No App Runner service ARN provided, skipping service update${NC}"
    fi
else
    echo -e "${RED}Error: Push to ECR failed${NC}"
    exit 1
fi