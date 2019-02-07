defmodule KomiChanWeb.ThreadsController do
  use KomiChanWeb, :controller

  alias KomiChan.Repositories.Thread, as: ThreadRepo

  action_fallback KomiChanWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", threads: ThreadRepo.all_threads())
  end

  def show(conn, %{"id" => thread_id}) do
    render(conn, "thread.json", thread: ThreadRepo.find(thread_id))
  end

  def create(conn, %{"thread" => thread}) do
    as_model = %ThreadRepo{board: thread["board"], comment: thread["comment"], title: thread["title"]}
    render(conn, "thread.json", thread: as_model |> ThreadRepo.create_thread())
  end
end
