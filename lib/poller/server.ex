defmodule Poller.Server do
  @moduledoc false
  use GenServer

  alias Poller.Client

  def start_link(args) do
    label = Keyword.fetch!(args, :label)
    name = name_via_registry(label)
    GenServer.start_link(__MODULE__, args, name: name)
  end

  def init(args) do
    client = Client.new(args)
    {:ok, client, {:continue, :start_poller}}
  end

  def handle_continue(:start_poller, client) do
    Process.send_after(self(), :poll, client.interval)
    {:noreply, client}
  end

  def handle_info(:poll, client) do
    client = Client.notify_next(client)
    Process.send_after(self(), :poll, client.interval)
    {:noreply, client}
  end

  defp name_via_registry(label) do
    {:via, Registry, {Poller.ServerRegistry, label}}
  end
end
