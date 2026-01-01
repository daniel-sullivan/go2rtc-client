#!/usr/bin/env pwsh
# Cross-platform PowerShell setup script

$ErrorActionPreference = "Stop"

$OPENAPI_URL = "https://raw.githubusercontent.com/AlexxIT/go2rtc/refs/heads/master/api/openapi.yaml"
$OPENAPI_FILE = "openapi.yaml"

Write-Host "=== go2rtc Client Setup ===" -ForegroundColor Cyan
Write-Host ""

# Check if Go is installed
if (-not (Get-Command go -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Go is not installed. Please install Go first." -ForegroundColor Red
    exit 1
}

Write-Host "Step 1/2: Downloading OpenAPI specification..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $OPENAPI_URL -OutFile $OPENAPI_FILE
Write-Host "OpenAPI spec downloaded successfully!" -ForegroundColor Green

Write-Host ""
Write-Host "Step 2/2: Generating Go client..." -ForegroundColor Yellow
go run github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest -config oapi-codegen.yaml $OPENAPI_FILE
Write-Host "Client generated successfully!" -ForegroundColor Green

Write-Host ""
Write-Host "=== Setup Complete ===" -ForegroundColor Cyan
Write-Host "Client library generated at client.go" -ForegroundColor Green
Write-Host ""
Write-Host "You can now import and use the client in your Go code:"
Write-Host '  import "github.com/daniel-sullivan/go2rtc-client"' -ForegroundColor Gray
