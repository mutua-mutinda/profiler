defmodule Profiler.AgeApi do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.agify.io")
  plug(Tesla.Middleware.JSON)

  def age(name) do
    get!("?name=" <> name)
  end
end
