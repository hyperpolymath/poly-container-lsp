# SPDX-License-Identifier: PMPL-1.0-or-later
# SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell <jonathan.jewell@open.ac.uk>

defmodule PolyContainerLSP do
  @moduledoc """
  PolyContainer LSP - Language Server Protocol for container runtimes.

  Provides IDE integration for container management across nerdctl, podman,
  and docker, enabling:

  - Auto-detection of available container runtimes
  - Container lifecycle management (run, build, inspect, logs)
  - Dockerfile/Containerfile diagnostics
  - Docker Compose validation
  - Auto-completion for container commands

  ## Architecture

  Built on Elixir's BEAM VM with isolated GenServer processes for each
  container runtime adapter, providing automatic fault recovery.

  ## Supported Runtimes

  - **nerdctl**: Docker-compatible CLI for containerd
  - **Podman**: Daemonless, rootless container engine
  - **Docker**: Industry standard container platform

  ## Example

      # Detect available runtimes
      {:ok, true} = PolyContainer.Adapters.Nerdctl.detect()

      # Run a container
      {:ok, container_id} = PolyContainer.Adapters.Nerdctl.run(
        "nginx:alpine",
        name: "web-server",
        ports: ["8080:80"],
        detach: true
      )

      # Inspect container
      {:ok, info} = PolyContainer.Adapters.Nerdctl.inspect(container_id)

      # View logs
      {:ok, %{logs: output}} = PolyContainer.Adapters.Nerdctl.logs(container_id, tail: 100)
  """

  @doc """
  Returns the version of the LSP server.
  """
  def version, do: "0.1.0"
end
