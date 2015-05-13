use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :elixir_stream, ElixirStream.Endpoint,
  secret_key_base: "MUJ4r0EHKHteNSsyTCFjXQOE0JG/7ap25FmNHsdCHjeJip2DA2YNnt4DiLNTy5XH"

# Configure your database
config :elixir_stream, ElixirStream.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "elixir_stream_phoenix_prod"
  size: 20 # The amount of database connections in the pool
