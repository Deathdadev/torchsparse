# Get versions from environment variables, with defaults
$cuda_version = $env:CUDA_VERSION
if (-not $cuda_version) { $cuda_version = "12.1" }

$pytorch_version = $env:PYTORCH_VERSION
if (-not $pytorch_version) { $pytorch_version = "latest" }

# Determine CUDA short version for wheel index
$cuda_short = switch ($cuda_version) {
  "11.8" { "cu118" }
  "12.1" { "cu121" }
  "12.4" { "cu124" }
  "12.6" { "cu126" }
  "12.8" { "cu128" }
  default {
    Write-Error "Unsupported CUDA version: $cuda_version"
    exit 1
  }
}

$index_url = "https://download.pytorch.org/whl/$cuda_short"
Write-Host "PyTorch wheel index: $index_url"

if ($pytorch_version -eq "latest") {
  Write-Host "Installing latest PyTorch for CUDA $cuda_version"
  pip install torch torchvision --index-url $index_url
} else {
  Write-Host "Installing PyTorch $pytorch_version for CUDA $cuda_version"
  pip install "torch==$pytorch_version" torchvision --index-url $index_url
}
