# SPDX-License-Identifier: PMPL-1.0-or-later
# SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell <jonathan.jewell@open.ac.uk>

defmodule PolyContainerLSPTest do
  use ExUnit.Case
  doctest PolyContainerLSP

  test "returns version" do
    assert PolyContainerLSP.version() == "0.1.0"
  end
end
