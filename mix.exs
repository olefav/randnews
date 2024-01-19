defmodule Randnews.MixProject do
  use Mix.Project

  def project do
    [
      app: :randnews,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:floki, "~> 0.21"},
      {:tesla, "~> 1.2"},
      {:hackney, "~> 1.14"},
      {:iconv, "~> 1.0.10"}
    ]
  end
end
