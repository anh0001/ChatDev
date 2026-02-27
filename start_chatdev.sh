#!/bin/bash
# ChatDev Startup Script
# This script activates the conda environment and starts ChatDev

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting ChatDev...${NC}"

# Activate conda environment
source ~/miniconda3/etc/profile.d/conda.sh
conda activate chatdev

# Navigate to ChatDev directory
cd "$(dirname "$0")"

echo -e "${YELLOW}Running ChatDev with 'make dev'...${NC}"
echo -e "${YELLOW}Backend will be available at: http://localhost:6400${NC}"
echo -e "${YELLOW}Frontend will be available at: http://localhost:5173${NC}"
echo ""
echo -e "${YELLOW}Press Ctrl+C to stop the servers${NC}"
echo ""

# Run ChatDev
make dev
