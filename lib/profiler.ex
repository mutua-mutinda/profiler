defmodule Profiler do
  use Application

  @impl true
  def start(_args, _type) do
    Profiler.Supervisor.start_link(name: Profiler.Supervisor)
  end
end
