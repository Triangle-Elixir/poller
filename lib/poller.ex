defmodule Poller do
  @moduledoc """
  Creates Poller instances which sends a `:call` message to a given list of
  processes at the provided `interval`.  These processes are queried by a
  given `registry_key` in the duplicate key registry, `Poller.ProcessRegistry`.
  """

  alias Poller.Server
  alias Poller.ProcessRegistry

  @doc """
  Create new poller server instance with given `label` as name.

  The Poller server instance will use the `registry_key` to lookup pids registered in the
  `ProcessRegistry` and send a `:call` message to the process at the provided `interval` in milliseconds.
  """
  @spec create_poller(Registry.value(), Registry.key(), non_neg_integer()) ::
    DynamicSupervisor.on_start_child()
  def create_poller(label, registry_key, interval) do
    args = [label: label, registry_key: registry_key, interval: interval]
    DynamicSupervisor.start_child(Poller.ServerSupervisor, {Server, args})
  end

  @doc """
  Registers a process for future `:call` callbacks
  """
  @spec register(String.t()) :: {:ok, pid()} | {:error, {:already_registered, pid()}}
  def register(registry_key) do
    Registry.register(ProcessRegistry, registry_key, self())
  end
end
