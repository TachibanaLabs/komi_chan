defmodule KomiChanWeb.ThreadController do
  use KomiChanWeb, :controller

  alias KomiChan.Repository.Threads, as: ThreadRepo

  action_fallback KomiChanWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", threads: ThreadRepo.all_threads())
  end
end
