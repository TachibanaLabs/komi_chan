defmodule KomiChanWeb.ThreadsController do
  use KomiChanWeb, :controller

  alias KomiChan.Repositories.Thread, as: ThreadRepo

  action_fallback KomiChanWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", threads: ThreadRepo.all())
  end

  def show(conn, %{"id" => thread_id}) do
    render(conn, "thread.json", thread: ThreadRepo.find(thread_id))
  end

  def create(
        conn,
        %{
          "thread" => %{
            "board" => board,
            "comment" => comment,
            "title" => title
          }
        }
      ) do
    as_model = %ThreadRepo{board: board, comment: comment, title: title}

    render(
      conn,
      "thread.json",
      thread: ThreadRepo.create(as_model)
    )
  end
end
