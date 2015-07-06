use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elixir_stream, ElixirStream.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :elixir_stream, ElixirStream.Repo,
  adapter: Ecto.Adapters.Postgres,
  host: "localhost",
  database: "elixir_stream_phoenix_test",
  pool: Ecto.Adapters.SQL.Sandbox
