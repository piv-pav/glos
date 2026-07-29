# Build glos binary
build:
    go build -ldflags "-X main.Version=$(cat .version)" -o glos .

# Install glos using go install
install:
    go install -ldflags "-X main.Version=$(cat .version)" .
    @echo "Installed to $(go env GOPATH)/bin/glos"

# Run tests
test:
    go test -v ./...

# Clean build artifacts
clean:
    rm -rf bin/ glos

# Install dependencies
deps:
    go mod download
    go mod tidy

# Format code
fmt:
    go fmt ./...

# Run linter
lint:
    go vet ./...

# Run example
run-example: build
    mkdir -p /tmp/example-docs
    echo "# Example Document\nThis is a test document about Go programming." > /tmp/example-docs/test.md
    ./glos index /tmp/example-docs
    ./glos search "programming"
    ./glos stats
