# PolyContainer LSP - VSCode Extension

Language Server Protocol extension for container runtime management.

## Features

- **Multi-runtime support**: nerdctl, podman, docker
- **Auto-detection**: Automatically detects available container runtimes
- **Container operations**: Run, build, inspect, logs
- **Dockerfile validation**: Diagnostics for Dockerfile/Containerfile
- **Docker Compose support**: Validation for compose files

## Requirements

At least one of the following container runtimes must be installed:

- [nerdctl](https://github.com/containerd/nerdctl)
- [podman](https://github.com/containers/podman)
- [docker](https://github.com/docker/cli)

Additionally, you need:

- Elixir 1.17+ (for running the LSP server)

## Installation

1. Clone the poly-container-lsp repository
2. Install dependencies: `cd poly-container-lsp && mix deps.get`
3. Install this extension in VSCode

## Configuration

- `polyContainerLsp.runtime`: Preferred container runtime (auto, nerdctl, podman, docker)
- `polyContainerLsp.trace.server`: Trace communication with the server

## Commands

- `PolyContainer: Run Container` - Run a container from current Dockerfile
- `PolyContainer: Build Image` - Build image from Dockerfile
- `PolyContainer: Inspect Container` - Inspect container details
- `PolyContainer: View Container Logs` - View container logs
- `PolyContainer: Detect Available Container Runtimes` - Check installed runtimes

## Development

This extension is part of the poly-container-lsp project.

See the main [README](../README.adoc) for development instructions.

## License

PMPL-1.0-or-later
