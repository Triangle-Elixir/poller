defmodule Poller.MixProject do
  use Mix.Project

  def project do
    [
      app: :poller,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
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
end
