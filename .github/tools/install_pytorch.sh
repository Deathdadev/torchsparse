#!/bin/bash
set -euxo pipefail

# Get versions from environment variables, with defaults
cuda_version="${CUDA_VERSION:-12.1}"
pytorch_version="${PYTORCH_VERSION:-latest}"

# Determine CUDA short version for wheel index
case "$cuda_version" in
  "11.8") cuda_short="cu118";;
  "12.1") cuda_short="cu121";;
  "12.4") cuda_short="cu124";;
  "12.6") cuda_short="cu126";;
  "12.8") cuda_short="cu128";;
  *)
    echo "Error: Unsupported CUDA version: $cuda_version"
    exit 1
    ;;
esac

index_url="https://download.pytorch.org/whl/$cuda_short"
echo "PyTorch wheel index: $index_url"

if [ "$pytorch_version" = "latest" ]; then
  echo "Installing latest PyTorch for CUDA $cuda_version"
  pip install torch torchvision --index-url "$index_url"
else
  echo "Installing PyTorch $pytorch_version for CUDA $cuda_version"
  pip install torch=="$pytorch_version" torchvision --index-url "$index_url"
fi
