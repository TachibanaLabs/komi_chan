defmodule KomiChanWeb.ThreadsController do
  use KomiChanWeb, :controller

  alias KomiChan.Repositories.Thread, as: ThreadRepo

  action_fallback KomiChanWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", threads: ThreadRepo.all_threads())
  end

  def show(conn, %{"id" => thread_id}) do
    found = thread_id |> String.to_integer |> ThreadRepo.find
    render(conn, "thread.json", thread: found)
  end

  def create(conn, %{"thread" => %{"board" => board, "comment" => comment, "title" => title}}) do
    as_model = %ThreadRepo{board: board, comment: comment, title: title}
    render(conn, "thread.json", thread: as_model |> ThreadRepo.create_thread())
  end
end
