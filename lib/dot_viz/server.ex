defmodule DotViz.Server do
  @moduledoc false

  use GenServer

  alias DotViz.Helper

  defstruct [:incoming_edges, :outgoing_edges, :nodes]

  def start_link(opts) do
    filename = Keyword.fetch!(opts, :filename)
    filepath = Keyword.fetch!(opts, :filepath)
    GenServer.start_link(__MODULE__, filepath, name: DotViz.Registry.name(filename))
  end

  def init(filepath) do
    stream = Helper.parse_file(filepath)
    incoming_edges = Helper.incoming_edges(stream)
    outgoing_edges = Helper.outgoing_edges(stream)
    nodes = Enum.uniq(Map.keys(incoming_edges) ++ Map.keys(outgoing_edges))

    {:ok,
     %__MODULE__{
       nodes: nodes,
       incoming_edges: incoming_edges,
       outgoing_edges: outgoing_edges
     }}
  end

  def get_nodes(pid), do: GenServer.call(pid, :get_nodes)

  def edges(pid, value), do: GenServer.call(pid, {:edges, value})

  def handle_call(:get_nodes, _from, state) do
    {:reply, {:ok, state.nodes}, state}
  end

  def handle_call({:edges, value}, _from, state) do
    edges = %{
      incoming_edges: Map.get(state.incoming_edges, value, []),
      outgoing_edges: Map.get(state.outgoing_edges, value, [])
    }

    {:reply, {:ok, edges}, state}
  end
end
