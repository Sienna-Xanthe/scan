defmodule Scan.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ScanWeb.Telemetry,
      # Start the Ecto repository
      Scan.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Scan.PubSub},
      # Start Finch
      {Finch, name: Scan.Finch},
      # Start the Endpoint (http/https)
      ScanWeb.Endpoint
      # Start a worker by calling: Scan.Worker.start_link(arg)
      # {Scan.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Scan.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ScanWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
