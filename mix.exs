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
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
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
      {:earmark, "~> 1.4"},
      {:excoveralls, "~> 0.14.4", only: :test}
    ]
  end

  defp escript_config() do
    [
      main_module: Issuex.CLI
    ]
  end
end
