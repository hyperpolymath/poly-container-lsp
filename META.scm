;; SPDX-License-Identifier: PMPL-1.0-or-later
;; META.scm - Meta-level project information

(define meta
  '((metadata
     (version "1.0")
     (created "2026-02-05")
     (updated "2026-02-05"))

    (architecture-decisions
     ((id "ADR-001")
      (title "Use Elixir and BEAM VM for LSP implementation")
      (status "accepted")
      (date "2026-02-05")
      (context "Need LSP server with fault tolerance and concurrent container operations")
      (decision "Use Elixir/BEAM for automatic fault recovery and process isolation")
      (consequences
       "Each adapter runs as supervised GenServer"
       "Adapter crashes don't affect other adapters"
       "Can handle multiple container operations concurrently"))

     ((id "ADR-002")
      (title "Support three container runtimes: nerdctl, podman, docker")
      (status "accepted")
      (date "2026-02-05")
      (context "Users may have different container runtimes installed")
      (decision "Support nerdctl (containerd), podman (OCI), and docker (docker-engine)")
      (consequences
       "Common adapter behaviour for consistency"
       "Runtime-specific features exposed where applicable"
       "Auto-detection of available runtimes"))

     ((id "ADR-003")
      (title "GenServer-based adapter architecture")
      (status "accepted")
      (date "2026-02-05")
      (context "Need state management and concurrent operation handling")
      (decision "Each adapter is a GenServer with supervisor")
      (consequences
       "State tracking for running containers"
       "Timeout handling for long operations"
       "Process isolation between adapters")))

    (development-practices
     (testing
      "Unit tests for each adapter"
      "Integration tests with actual container runtimes"
      "Mock-based tests for CI without container runtime dependencies")
     (documentation
      "Inline module documentation with @moduledoc"
      "Function documentation with @doc"
      "Type specifications with @type and @spec"
      "README with quick start and examples")
     (code-quality
      "Formatted with mix format"
      "Linted with Credo"
      "Type-checked with Dialyzer"
      "SPDX license headers on all files"))

    (design-rationale
     (adapter-behaviour
      "Defines contract for all container runtime adapters"
      "Ensures consistent API across nerdctl, podman, docker"
      "Callbacks: detect, run, build, inspect, logs, version, metadata")
     (genserver-pattern
      "Each adapter is stateful GenServer"
      "Tracks running containers and builds"
      "Handles timeouts for long-running operations"
      "Provides fault isolation")
     (supervisor-tree
      "Adapter supervisor manages all runtime adapters"
      "One-for-one restart strategy"
      "Automatic recovery on adapter crashes")
     (lsp-integration
      "GenLSP framework for LSP server implementation"
      "Standard LSP protocol handlers"
      "Container operations exposed as LSP commands"))))
