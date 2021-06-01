defmodule Ana.MixProject do
  use Mix.Project

  def project do
    [
      app: :ana,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 2.7"},
      {:plug_cowboy, "~> 2.4.1"},
      {:jason, "~> 1.2"},
      {:websockex, "~> 0.4.3", only: [:dev, :test]}
    ]
  end
end
