#!/bin/bash
set -e

OPENAPI_URL="https://raw.githubusercontent.com/AlexxIT/go2rtc/refs/heads/master/api/openapi.yaml"
OPENAPI_FILE="openapi.yaml"

echo "=== go2rtc Client Setup ==="
echo ""

# Check if Go is installed
if ! command -v go &> /dev/null; then
    echo "Error: Go is not installed. Please install Go first."
    exit 1
fi

echo "Step 1/2: Downloading OpenAPI specification..."
curl -fsSL "$OPENAPI_URL" -o "$OPENAPI_FILE"
echo "OpenAPI spec downloaded successfully!"

echo ""
echo "Step 2/2: Generating Go client..."
go run github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest -config oapi-codegen.yaml "$OPENAPI_FILE"
echo "Client generated successfully!"

echo ""
echo "=== Setup Complete ==="
echo "Client library generated at client.go"
echo ""
echo "You can now import and use the client in your Go code:"
echo "  import \"github.com/daniel-sullivan/go2rtc-client\""
