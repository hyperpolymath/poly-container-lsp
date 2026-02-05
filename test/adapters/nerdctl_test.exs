# SPDX-License-Identifier: PMPL-1.0-or-later
# SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell <jonathan.jewell@open.ac.uk>

defmodule PolyContainer.Adapters.NerdctlTest do
  use ExUnit.Case

  alias PolyContainer.Adapters.Nerdctl

  describe "metadata/0" do
    test "returns correct metadata" do
      metadata = Nerdctl.metadata()

      assert metadata.name == "nerdctl"
      assert metadata.implementation == "containerd"
      assert metadata.rootless == true
      assert "docker-compatible" in metadata.features
      assert "rootless" in metadata.features
    end
  end

  describe "detect/0" do
    test "detects if nerdctl is available" do
      {:ok, available} = Nerdctl.detect()
      assert is_boolean(available)
    end
  end
end
