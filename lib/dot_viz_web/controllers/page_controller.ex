defmodule DotVizWeb.PageController do
  use DotVizWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
