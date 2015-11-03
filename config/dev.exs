use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :elixir_stream, ElixirStream.Endpoint,
  http: [port: 3000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch"]]

# Watch static and templates for browser reloading.
config :elixir_stream, ElixirStream.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"
config :elixir_stream, :basic_auth,
  username: "admin",
  password: "admin"

config :ex_twitter, :oauth, [
   consumer_key: "",
   consumer_secret: "",
   access_token: "",
   access_token_secret: ""
  ]


# Configure your database
config :elixir_stream, ElixirStream.Repo,
  adapter: Ecto.Adapters.Postgres,
  host: "localhost",
  database: "elixir_stream_phoenix_dev"
