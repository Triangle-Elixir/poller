# Poller

A simple elixir application that calls processes at a given interval.

This application might be useful for limiting the amount of process calls within
a given time period.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `poller` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:poller, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/poller](https://hexdocs.pm/poller).


## Copyright and License

Copyright (c) 2019, Jeffrey Gillis

Poller source code is licensed under the [MIT License](LICENSE.md)
