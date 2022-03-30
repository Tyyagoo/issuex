defmodule Issuex.MixProject do
  use Mix.Project

  def project do
    [
      app: :issuex,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      name: "Issuex",
      source_url: "https://github.com/Tyyagoo/issuex",
      deps: deps(),
      escript: escript_config()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.3"},
      {:table_rex, "~> 3.1"},
      {:ex_doc, "~> 0.28.3"},
      {:earmark, "~> 1.4"}
    ]
  end

  defp escript_config() do
    [
      main_module: Issuex.CLI
    ]
  end
end
