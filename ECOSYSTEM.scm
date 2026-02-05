;; SPDX-License-Identifier: PMPL-1.0-or-later
;; ECOSYSTEM.scm - Project ecosystem position

(ecosystem
  (version "1.0")
  (name "poly-container-lsp")
  (type "language-server")
  (purpose "IDE integration for container runtime management")

  (position-in-ecosystem
   (domain "Developer Tools")
   (category "Language Server Protocol")
   (subcategory "Container Management"))

  (related-projects
   ((name "poly-ssg-lsp")
    (repo "hyperpolymath/poly-ssg-lsp")
    (relationship "sibling-project")
    (description "LSP for static site generators")
    (shared-patterns
     "Elixir/BEAM architecture"
     "GenServer-based adapters"
     "Adapter behaviour pattern"
     "Supervised process tree"))

   ((name "poly-ssg-mcp")
    (repo "hyperpolymath/poly-ssg-mcp")
    (relationship "sibling-project")
    (description "MCP for static site generators")
    (shared-patterns
     "Multi-tool adapter pattern"
     "Auto-detection mechanism"))

   ((name "nerdctl")
    (url "https://github.com/containerd/nerdctl")
    (relationship "integration-target")
    (description "Docker-compatible CLI for containerd")
    (integration-method "Command-line wrapper"))

   ((name "podman")
    (url "https://github.com/containers/podman")
    (relationship "integration-target")
    (description "Daemonless OCI container engine")
    (integration-method "Command-line wrapper"))

   ((name "docker")
    (url "https://github.com/docker/cli")
    (relationship "integration-target")
    (description "Industry standard container platform")
    (integration-method "Command-line wrapper"))

   ((name "GenLSP")
    (url "https://github.com/elixir-lsp/gen_lsp")
    (relationship "dependency")
    (description "Generic LSP server framework for Elixir")
    (purpose "LSP protocol implementation")))

  (potential-extensions
   "poly-k8s-lsp - Kubernetes LSP"
   "poly-compose-lsp - Docker Compose specific LSP"
   "poly-container-mcp - Container MCP server"
   "Container security scanning integration"
   "Image vulnerability detection"
   "Registry integration (Docker Hub, GHCR, etc.)")

  (design-influences
   ((source "poly-ssg-lsp")
    (influence "Adapter behaviour pattern")
    (influence "GenServer architecture")
    (influence "Supervisor structure"))

   ((source "Elixir ecosystem")
    (influence "Fault tolerance via BEAM")
    (influence "Process isolation")
    (influence "Hot code reloading"))

   ((source "LSP Specification")
    (influence "Standard protocol handlers")
    (influence "JSON-RPC communication")
    (influence "Diagnostics and completion"))))
