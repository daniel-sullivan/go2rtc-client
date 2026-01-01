# go2rtc Go Client Library

[![Go Reference](https://pkg.go.dev/badge/github.com/daniel-sullivan/go2rtc-client.svg)](https://pkg.go.dev/github.com/daniel-sullivan/go2rtc-client)

A Go client library for [go2rtc](https://github.com/AlexxIT/go2rtc), automatically generated from the official OpenAPI specification.

## Installation

```bash
go get github.com/daniel-sullivan/go2rtc-client
```

## Quick Start

```go
package main

import (
    "context"
    "fmt"
    "log"

    go2rtc "github.com/daniel-sullivan/go2rtc-client"
)

func main() {
    // Create a new client
    client, err := go2rtc.NewClient("http://localhost:1984")
    if err != nil {
        log.Fatal(err)
    }

    // Use the client
    ctx := context.Background()

    // Example: Get application info
    // resp, err := client.GetApi(ctx)
    // if err != nil {
    //     log.Fatal(err)
    // }
    // fmt.Printf("Version: %v\n", resp)
}
```

## Development Prerequisites

- Go 1.25 or later
- Internet connection (to download the OpenAPI spec)

## How It Works

This library contains pre-generated client code (`client.go`) that is committed to the repository. Users can simply import and use the library without needing to run any code generation themselves.

For maintainers, the code generation process:

1. Downloads the OpenAPI spec from the go2rtc repository
2. Runs `oapi-codegen` via `go run` to generate the client code
3. Commits the generated `client.go` to the repository
4. Creates a release matching the go2rtc version

## Versioning

This library follows the same version tags as go2rtc. Each release of this library corresponds to a specific version of go2rtc.

For example:
- `v1.9.13` of this library is generated from go2rtc `v1.9.13`
- `v1.9.12` of this library is generated from go2rtc `v1.9.12`

To use a specific version:
```bash
go get github.com/daniel-sullivan/go2rtc-client@v1.9.13
```

## Automated Releases

Releases are automated via GitHub Actions. When you publish a release:

1. The workflow is triggered automatically
2. It downloads the OpenAPI spec from the matching go2rtc version
3. Generates the client code
4. Commits the generated code
5. Updates the release description with installation instructions

The release description is updated in real-time showing generation progress!

---

## Development Setup

This section is for developers who want to contribute to or modify the code generation process.

### Setup Options

This project provides multiple platform-agnostic setup options. Choose the one that works best for your environment:

### Option 1: Using Make (Recommended)

```bash
make setup
```

This will:
1. Download the latest OpenAPI specification from go2rtc
2. Generate the Go client library using `go run`

Other useful make targets:
```bash
make help           # Show all available targets
make download-spec  # Just download the OpenAPI spec
make generate       # Just generate the client (requires openapi.yaml)
make clean          # Remove generated files
```

### Option 2: Using Shell Script (Linux/Mac/Unix)

```bash
chmod +x setup.sh
./setup.sh
```

### Option 3: Using PowerShell (Windows/Cross-platform)

```powershell
# Windows PowerShell or PowerShell Core
.\setup.ps1

# Or on Unix/Mac with PowerShell Core
pwsh setup.ps1
```

### Option 4: Manual Setup

If you prefer to run the commands manually:

```bash
# 1. Download the OpenAPI specification
curl -fsSL https://raw.githubusercontent.com/AlexxIT/go2rtc/refs/heads/master/api/openapi.yaml -o openapi.yaml

# 2. Generate the client
go run github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest -config oapi-codegen.yaml openapi.yaml
```

### Testing Generated Code Locally

After running the setup, you can test the generated client:

```go
package main

import (
    "context"
    "log"
    go2rtc "github.com/daniel-sullivan/go2rtc-client"
)

func main() {
    // Create a new client
    client, err := go2rtc.NewClient("http://localhost:1984")
    if err != nil {
        log.Fatal(err)
    }

    // Use the client
    ctx := context.Background()
    // Example: Make API calls using the generated client methods
    // resp, err := client.GetApi(ctx)
    // ...
}
```

## Project Structure

```
.
├── .github/
│   └── workflows/
│       └── release.yml           # Automated release workflow
├── client.go                     # Generated client library (committed to git)
├── openapi.yaml                  # Downloaded OpenAPI spec (not committed, dev only)
├── oapi-codegen.yaml             # Code generator configuration
├── Makefile                      # Make-based build script (for maintainers)
├── setup.sh                      # Unix/Linux/Mac setup script (for maintainers)
├── setup.ps1                     # PowerShell setup script (for maintainers)
├── go.mod                        # Go module definition
└── README.md                     # This file
```

**Important Notes:**
- `client.go` is **committed to git** so users get the generated code without needing to run generation
- `openapi.yaml` is only used during code generation and is not committed
- The setup scripts and Makefile are for maintainers who need to regenerate the client code

## Regenerating the Client

To regenerate the client with the latest OpenAPI specification:

```bash
# Using Make
make clean setup

# Using shell script
./setup.sh

# Using PowerShell
.\setup.ps1
```

## Configuration

The client generation is configured in `oapi-codegen.yaml`. You can customize:
- Package name
- Output file location
- What to generate (client, models, embedded spec, etc.)
- Output options (e.g., skip-prune)

## Creating a New Release

To create a new release matching a go2rtc version:

1. Go to the [Releases page](../../releases) in GitHub
2. Click "Draft a new release"
3. Enter the tag (e.g., `v1.9.13`) - **must match a go2rtc release tag**
4. Enter a release title (e.g., `Release v1.9.13`)
5. Click "Publish release"

The workflow will automatically:
- Detect the release publication
- Update the release description with progress messages
- Download the OpenAPI spec from the matching go2rtc tag
- Generate the client code
- Delete the temporary tag
- Commit the generated code to the repository
- Recreate the tag pointing to the new commit
- Update the release with full installation instructions

You can watch the progress in real-time by refreshing the release page!

## License

This client library generator follows the same license as go2rtc. See the [go2rtc repository](https://github.com/AlexxIT/go2rtc) for details.
