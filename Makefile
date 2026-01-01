.PHONY: setup generate clean download-spec help

OPENAPI_URL := https://raw.githubusercontent.com/AlexxIT/go2rtc/refs/heads/master/api/openapi.yaml
OPENAPI_FILE := openapi.yaml
CLIENT_FILE := client.go
CODEGEN := go run github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest

help:
	@echo "Available targets:"
	@echo "  setup          - Complete setup: download spec and generate client"
	@echo "  download-spec  - Download the latest OpenAPI specification"
	@echo "  generate       - Generate Go client from OpenAPI spec"
	@echo "  clean          - Remove generated files"

setup: download-spec generate
	@echo "Setup complete!"

download-spec:
	@echo "Downloading OpenAPI specification..."
	@curl -fsSL $(OPENAPI_URL) -o $(OPENAPI_FILE)
	@echo "OpenAPI spec downloaded to $(OPENAPI_FILE)"

generate: $(CLIENT_FILE)

$(CLIENT_FILE): $(OPENAPI_FILE) oapi-codegen.yaml
	@echo "Generating Go client..."
	@go clean -cache
	@$(CODEGEN) -config oapi-codegen.yaml $(OPENAPI_FILE)
	@echo "Client generated successfully!"

clean:
	@echo "Cleaning generated files..."
	@rm -f $(CLIENT_FILE)
	@rm -f $(OPENAPI_FILE)
	@echo "Clean complete!"
