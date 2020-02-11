defmodule Poller.MixProject do
  use Mix.Project

  def project do
    [
      app: :poller,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      docs: docs(),
      deps: deps(),
      description: description(),
      package: package(),
      name: "Poller",
      source_url: "https://github.com/Triangle-Elixir/poller"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Poller.App, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev, :test], runtime: false}
    ]
  end

  defp description() do
    "A simple application that will allow you to do work at a defined interval."
  end

  defp package() do
    [
      name: "poller",
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/Triangle-Elixir/poller"},
      maintainers: ["Jeffrey Gillis"]
    ]
  end

  defp docs() do
    [
      main: "Poller",
      extras: ["pages/example.md"]
    ]
  end
end
