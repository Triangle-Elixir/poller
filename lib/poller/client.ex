defmodule Poller.Client do
  @moduledoc false
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
      client.registry_key
      |> get_processes()

    notify_next(%__MODULE__{client | current_list: processes})
  end

  def notify_next(client) do
    [process | rest] = client.current_list

    process
    |> valid_process?(client.registry_key)
    |> notify(process)

    %__MODULE__{client | current_list: rest}
  end

  defp get_processes(registry_key) do
    ProcessRegistry
    |> Registry.lookup(registry_key)
    |> Enum.map(fn {pid, _} -> pid end)
  end

  defp valid_process?(process, registry_key) do
    with true <- Process.alive?(process),
         processes <- get_processes(registry_key) do
      Enum.any?(processes, &(&1 == process))
    end
  end

  defp notify(true, pid) when is_pid(pid) do
    Process.send(pid, :call, [])
  end

  defp notify(_boolean, _pid), do: :ok
end
