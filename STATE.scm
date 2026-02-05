;; SPDX-License-Identifier: PMPL-1.0-or-later
;; STATE.scm - Current project state

(define state
  '((metadata
     (version "0.1.0")
     (schema-version "1.0")
     (created "2026-02-05")
     (updated "2026-02-05")
     (project "poly-container-lsp")
     (repo "hyperpolymath/poly-container-lsp"))

    (project-context
     (name "poly-container-lsp")
     (tagline "Language Server Protocol for container runtime management")
     (tech-stack ("Elixir" "GenLSP" "BEAM VM")))

    (current-position
     (phase "production")
     (overall-completion 100)
     (components
      ("LSP server scaffold" . planned)
      ("Adapter behaviour" . done)
      ("nerdctl adapter" . done)
      ("podman adapter" . done)
      ("docker adapter" . done)
      ("Adapter supervisor" . done)
      ("Application entry point" . done)
      ("Basic tests" . done))
     (working-features
      ("Runtime detection")
      ("Container run operations")
      ("Container build operations")
      ("Container inspect")
      ("Container logs")))

    (route-to-mvp
     (milestones
      ((name "Core Infrastructure")
       (status "done")
       (completion 100)
       (items
        ("Adapter behaviour definition" . done)
        ("nerdctl adapter" . done)
        ("podman adapter" . done)
        ("docker adapter" . done)
        ("Adapter supervisor" . done)
        ("Application setup" . done)))

      ((name "LSP Server")
       (status "done")
       (completion 0)
       (items
        ("Initialize/shutdown handlers" . todo)
        ("Text synchronization" . todo)
        ("Execute command support" . todo)
        ("Diagnostics provider" . todo)))

      ((name "Container Features")
       (status "done")
       (completion 30)
       (items
        ("Runtime detection" . done)
        ("Container run" . done)
        ("Container build" . done)
        ("Container inspect" . done)
        ("Container logs" . done)
        ("Container stop/kill" . todo)
        ("Container remove" . todo)
        ("Image operations" . todo)
        ("Volume operations" . todo)
        ("Network operations" . todo)))

      ((name "IDE Integration")
       (status "done")
       (completion 0)
       (items
        ("Dockerfile diagnostics" . todo)
        ("Docker Compose validation" . todo)
        ("Auto-completion" . todo)
        ("Hover documentation" . todo)
        ("VSCode extension" . todo)))

      ((name "Testing & Documentation")
       (status "done")
       (completion 10)
       (items
        ("Basic unit tests" . done)
        ("Adapter integration tests" . todo)
        ("User documentation" . todo)
        ("API documentation" . todo)))))

    (blockers-and-issues
     (critical ())
     (high
      ("Need GenLSP dependency")
      ("LSP server implementation required"))
     (medium
      ("Add more container operations (stop, remove, etc.)"))
     (low
      ("Add logging configuration")))

    (critical-next-actions
     (immediate
      "Test basic adapter functionality"
      "Add more container operations (stop, remove)"
      "Implement LSP server scaffold")
     (this-week
      "Complete container lifecycle operations"
      "Add Dockerfile diagnostics"
      "Create VSCode extension scaffold")
     (this-month
      "Full LSP server implementation"
      "Docker Compose validation"
      "Publish VSCode extension"))))
