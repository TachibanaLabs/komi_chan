defmodule KomiChanWeb.Router do
  use KomiChanWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", KomiChanWeb do
    pipe_through :api
  end
end
