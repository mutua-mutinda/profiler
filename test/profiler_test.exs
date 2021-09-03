defmodule ProfilerTest do
  use ExUnit.Case
  doctest Profiler

  test "data" do
    assert Profiler.Manager.profile()
  end
end
