# Example Usage

## Create Your Poller

Somewhere in your app you would create the poller. In the example below we will
create a poller when MyApp starts itself to help throttle API calls to a Weather
API. This will help our app throttle itself for anything needing to use the
Weather API.

```elixir
defmodule MyApp do
  use Application

  def start(_type, _args) do
    # Start the poller
    {:ok, _pid} =
      Poller.create_poller("Weather API Poller", "weather", :timer.seconds(5))

    children = []

    Supervisor.start_link(children, strategy: :one_for_one, name:
    MyApp.Supervisor)
  end
end
```

This will create a poller that will send a call to any other processes
registered to the poller. This is tracked in the [Elixir Registry].

[Elixir Registry]: https://hexdocs.pm/elixir/Registry.html

## Subscribe to Your Poller

Now we will create a `GenServer` that can respond to the poller. The poller will
send a `call` message to your process which is handled with a `handle_info/2`.
Let's try that out:

```elixir
defmodule MyApp.Weather do
  use GenServer

  @impl GenServer
  def init(state) do
    Poller.register("weather")
    {:ok, state}
  end

  @impl GenServer
  def handle_info(:call, state) do
    results = WeatherApi.use_throttled_endpoint(%{zip: "90210"})
    {:noreply, Map.put(state, :results, result)}
  end
end
```

Now our API is throttled to 1 API call per 5 seconds.

# Multiple Processes on the same Poller

If we create and register another GenServer process that used the same weather
API and registered it to the same `"weather"` poller, all API calls to that
server would be throttled together. `Poller` rotates through registered
processes in a round-robin fashion, so each process would be called once every
10 seconds.

| Time | Event   |
| ---- | ------- |
| 0    | Started Poller with 5 second interval |
| 1    | Registered GenServerOne |
| 5    | GenServerOne called |
| 7    | Registered GenServerTwo |
| 10   | GenServerOne called |
| 15   | GenServerTwo called |
| 18   | GenServerOne dies |
| 20   | GenServerTwo called |
| 25   | GenServerTwo called |

