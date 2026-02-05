# SPDX-License-Identifier: PMPL-1.0-or-later
defmodule PolyLSP.Adapters.PodmanTest do
  use ExUnit.Case
  alias PolyLSP.Adapters.Podman

  describe "detect/1" do
    test "returns true when config exists" do
      assert {:ok, true} = Podman.detect(".")
    end
  end

  describe "version/0" do
    test "returns version string" do
      case Podman.version() do
        {:ok, version} -> assert is_binary(version)
        {:error, _} -> :ok  # CLI not installed
      end
    end
  end

  describe "metadata/0" do
    test "returns valid metadata" do
      meta = Podman.metadata()
      assert is_map(meta)
      assert Map.has_key?(meta, :name)
    end
  end
end
