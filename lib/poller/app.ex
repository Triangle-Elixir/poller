defmodule Poller.App do
  use Application

  def start(_type, _args) do
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: Poller.ServerSupervisor},
      {Registry, keys: :unique, name: Poller.ServerRegistry},
      {Registry, keys: :duplicate, name: Poller.ProcessRegistry}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Poller.AppSupervisor)
  end
end
