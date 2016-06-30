# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :elixir_stream,
  ecto_repos: [ElixirStream.Repo]

# Configures the endpoint
config :elixir_stream, ElixirStream.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Bh92d59cbz3kKIfaFxeqEK/8LUPHV4tiirttImfeIVS0f94WByg3wo0yDABTTQY3",
  render_errors: [view: ElixirStream.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ElixirStream.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
