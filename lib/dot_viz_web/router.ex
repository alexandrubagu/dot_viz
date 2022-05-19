defmodule DotVizWeb.Router do
  use DotVizWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DotVizWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DotVizWeb do
    pipe_through :browser

    get "/", DefaultController, :index
    get "/nodes/:filename", DefaultController, :nodes
    get "/edges/:filename/:module", DefaultController, :edges
  end
end
