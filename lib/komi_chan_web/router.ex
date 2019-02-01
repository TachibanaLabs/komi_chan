defmodule KomiChanWeb.Router do
  use KomiChanWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KomiChanWeb do
    pipe_through :api
    resources "/threads", ThreadController, except: [:new, :edit]
  end
end
