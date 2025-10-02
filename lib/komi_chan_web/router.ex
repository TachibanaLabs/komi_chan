defmodule KomiChanWeb.Router do
  use KomiChanWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {KomiChanWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KomiChanWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/boards", BoardLive.Index, :index
    live "/boards/new", BoardLive.Form, :new
    live "/boards/:id", BoardLive.Show, :show
    live "/boards/:id/edit", BoardLive.Form, :edit

    live "/threads", ThreadLive.Index, :index
    live "/threads/new", ThreadLive.Form, :new
    live "/threads/:id", ThreadLive.Show, :show
    live "/threads/:id/edit", ThreadLive.Form, :edit

    live "/posts", PostLive.Index, :index
    live "/posts/new", PostLive.Form, :new
    live "/posts/:id", PostLive.Show, :show
    live "/posts/:id/edit", PostLive.Form, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", KomiChanWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:komi_chan, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: KomiChanWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
