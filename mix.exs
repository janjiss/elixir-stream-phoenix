defmodule ElixirStream.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_stream,
     version: "0.0.3",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {ElixirStream, []},
     applications: [:phoenix, :cowboy, :logger, :exrm, :earmark,
      :comeonin, :postgrex, :phoenix_html, :phoenix_ecto,
      :timex, :extwitter, :oauth, :plug_basic_auth]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 0.14.0"},
      {:phoenix_ecto, "~> 0.5"},
      {:postgrex, ">= 0.8.2"},
      {:phoenix_html, "~> 1.2"},
      {:phoenix_live_reload, "~> 0.4", only: :dev},
      {:cowboy, "~> 1.0"},
      {:comeonin, "~> 0.8"},
      {:exrm, "~> 0.17.3"},
      {:earmark, "~> 0.1.17"},
      {:timex, "~> 0.15.0"},
      {:oauth, github: "tim/erlang-oauth"},
      {:extwitter, "~> 0.2"},
      {:plug_basic_auth, "~> 0.3.3"}
    ]
  end
end
