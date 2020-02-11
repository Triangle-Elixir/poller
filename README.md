# Poller

A simple elixir application that calls processes at a given interval.

This application might be useful for limiting the amount of process calls within
a given time period.

## Usage

[See guide](./pages/example.md)

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

## Copyright and License

Copyright (c) 2020, Jeffrey Gillis

Poller source code is licensed under the [MIT License](LICENSE.md)
