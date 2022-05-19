defmodule DotViz.Registry do
  @moduledoc false

  def child_spec(_opts) do
    %{
      id: __MODULE__,
      start: {Registry, :start_link, [[name: __MODULE__, keys: :unique]]},
      type: :supervisor
    }
  end

  def name(filename), do: {:via, Registry, {__MODULE__, filename}}

  def all() do
    Registry.select(__MODULE__, [{{:"$1", :"$2", :"$3"}, [], [%{filename: :"$1", pid: :"$2"}]}])
  end
end
