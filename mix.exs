defmodule KomiChan.MixProject do
  use Mix.Project

  def project do
    [
      app: :komi_chan,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {KomiChan.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.0"},
      {:phoenix_pubsub, "~> 1.1"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:memento, "~> 0.3.1"},
      {:cors_plug, "~> 2.0"},
      {:credo, "~> 1.7.0", only: [:dev, :test], runtime: false},
      {:husky, "~> 1.0", only: :dev, runtime: false},
      {:vex, "~> 0.9.0"},
      {:ex_machina, "~> 2.3", only: :test}
    ]
  end
end
