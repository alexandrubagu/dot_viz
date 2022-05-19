defmodule DotViz.Application do
  @moduledoc false

  use Application

  @samples_path "priv/samples/"

  @impl true
  def start(_type, _args) do
    children =
      [
        DotVizWeb.Telemetry,
        {Phoenix.PubSub, name: DotViz.PubSub},
        DotVizWeb.Endpoint,
        DotViz.Registry
      ] ++ application_children()

    opts = [strategy: :one_for_one, name: DotViz.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DotVizWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp application_children() do
    @samples_path
    |> File.ls!()
    |> Enum.map(&{DotViz.Server, [filename: &1, filepath: @samples_path <> &1]})
  end

  def filenames(), do: {:ok, Enum.map(DotViz.Registry.all(), & &1.filename)}

  def server_pid(filename) do
    {:ok,
     DotViz.Registry.all()
     |> Enum.find(&(&1.filename == filename))
     |> Map.get(:pid)}
  end
end
