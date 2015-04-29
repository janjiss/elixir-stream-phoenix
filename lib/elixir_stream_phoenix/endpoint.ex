defmodule ElixirStream.Endpoint do
  use Phoenix.Endpoint, otp_app: :elixir_stream

  # Serve at "/" the given assets from "priv/static" directory
  plug Plug.Static,
    at: "/", from: :elixir_stream,
    only: ~w(css images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_elixir_stream_phoenix_key",
    signing_salt: "TXX4jPMo",
    encryption_salt: "79wkPHEI"

  plug :router, ElixirStream.Router
end
