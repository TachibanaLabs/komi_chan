defmodule KomiChanWeb.Router do
  use KomiChanWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KomiChanWeb do
    pipe_through :api
    resources "/threads", ThreadsController, only: [:index, :show, :create]
    resources "/boards", BoardsController, only: [:index, :show, :create]
  end
end
