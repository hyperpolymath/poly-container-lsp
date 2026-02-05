# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial project structure
- Adapter behaviour for container runtimes
- nerdctl adapter with full container lifecycle support
- Podman adapter with pod support
- Docker adapter with standard operations
- Adapter supervisor for fault isolation
- Container operations: run, build, inspect, logs
- Runtime auto-detection
- VSCode extension scaffold
- Basic test suite
- Checkpoint files (STATE.scm, META.scm, ECOSYSTEM.scm)

## [0.1.0] - 2026-02-05

### Added

- Initial release
- Core adapter architecture
- Three container runtime adapters (nerdctl, podman, docker)
- Basic container operations
