defmodule Poller.Client do
  defstruct label: "",
            registry_key: "",
            interval: :timer.seconds(1),
            current_list: []

  alias Poller.ProcessRegistry

  def new(args) do
    registry_key = Keyword.fetch!(args, :registry_key)
    interval = Keyword.fetch!(args, :interval)
    label = Keyword.fetch!(args, :label)
    %__MODULE__{label: label, registry_key: registry_key, interval: interval}
  end

  def notify_next(%__MODULE__{current_list: []} = client) do
    processes =
      ProcessRegistry
      |> Registry.lookup(client.registry_key)
      |> Enum.map(fn {pid, _} -> pid end)

    notify_next(%__MODULE__{client | current_list: processes})
  end

  def notify_next(client) do
    [process | rest] = client.current_list
    notify(process)
    %__MODULE__{client | current_list: rest}
  end

  defp notify(pid) when is_pid(pid) do
    case Process.alive?(pid) do
      true ->
        Process.send(pid, :call, [])

      _ ->
        :ok
    end
  end

  defp notify(_pid) do
    :ok
  end
end
