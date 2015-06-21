# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :elixir_stream, ElixirStream.Endpoint,
  url: [host: "localhost"],
  root: Path.expand("..", __DIR__),
  secret_key_base: "Bh92d59cbz3kKIfaFxeqEK/8LUPHV4tiirttImfeIVS0f94WByg3wo0yDABTTQY3",
  debug_errors: false,
  pubsub: [name: ElixirStream.PubSub,
           adapter: Phoenix.PubSub.PG2],
  session: [store: :cookie,
           key: "gp6cONncGLws1zaQYhxJ9w=="]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
