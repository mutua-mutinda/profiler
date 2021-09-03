defmodule Profiler.GithubWorker do
  use GenServer

  def start_link(opts) do
    IO.inspect("Githubuworker start_link/1)")
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    IO.inspect("Githubuworker init/1)")
    Process.send_after(self(), :refresh, 10000)
    {:ok, %{}}
  end

  @impl true
  def handle_call(:profile, _caller, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_info(:refresh, _state) do
    IO.inspect("Githubuworker handle_info({:refresh, state})")
    HTTPoison.start()
    %{body: body} = HTTPoison.get!("https://api.github.com/users/mutua-mutinda")

    response = Jason.decode!(body)
    new_state = Map.take(response, ["name", "login", "avatar_url"])
    GenServer.cast(Profiler.Manager, {:update_and_merge, __MODULE__, new_state})

    Process.send_after(self(), :refresh, 10000)

    {:noreply, new_state}
  end

  @impl true
  def handle_info(_, state) do
    {:noreply, state}
  end
end
