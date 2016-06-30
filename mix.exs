defmodule ElixirStream.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_stream,
     version: "0.0.5",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {ElixirStream, []},
     applications: [:phoenix, :cowboy, :logger, :exrm, :earmark,
      :comeonin, :postgrex, :phoenix_html, :phoenix_ecto,
      :timex, :extwitter, :oauth, :plug_basic_auth, :httpoison]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 1.2"},
      {:phoenix_ecto, "~> 3.0"},
      {:phoenix_html, "~> 2.6"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:httpoison, "~> 0.9.0"},
      {:postgrex, "~> 0.11.2"},
      {:cowboy, "~> 1.0"},
      {:comeonin, "~> 2.5"},
      {:exrm, "~> 1.0"},
      {:earmark, "~> 0.2.1"},
      {:timex, "~> 2.2"},
      {:oauth, github: "tim/erlang-oauth"},
      {:extwitter, "~> 0.7.1"},
      {:plug_basic_auth, "~> 1.1"}
    ]
  end

  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
    "ecto.reset": ["ecto.drop", "ecto.setup"],
    "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
