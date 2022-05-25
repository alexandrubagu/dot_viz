defmodule DotVizWeb.DefaultController do
  use DotVizWeb, :controller

  def index(conn, _params) do
    with {:ok, filenames} <- DotViz.Application.filenames() do
      render(conn, "index.html", filenames: filenames)
    end
  end

  def nodes(conn, %{"filename" => filename}) do
    with {:ok, pid} <- DotViz.Application.server_pid(filename),
         {:ok, nodes} <- DotViz.Server.get_nodes(pid) do
      json(conn, %{nodes: nodes})
    end
  end

  def edges(conn, %{"filename" => filename, "module" => module}) do
    with {:ok, pid} <- DotViz.Application.server_pid(filename),
         {:ok, edges} <- DotViz.Server.edges(pid, module) do
      json(conn, %{edges: edges, current_node: module})
    end
  end
end
