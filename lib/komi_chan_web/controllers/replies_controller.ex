defmodule KomiChanWeb.RepliesController do
  use KomiChanWeb, :controller

  alias KomiChan.Repositories.Reply, as: ReplyRepo

  action_fallback KomiChanWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", replies: ReplyRepo.all())
  end

  def show(conn, %{"id" => reply_id}) do
    render(conn, "reply.json", reply: ReplyRepo.find(reply_id))
  end

  def create(
        conn,
        %{
          "reply" => %{
            "comment" => comment,
            "board" => board,
            "thread" => thread
          }
        }
      ) do
    as_model = %ReplyRepo{comment: comment, board: board, thread: thread}

    render(
      conn,
      "reply.json",
      reply: ReplyRepo.create(as_model)
    )
  end
end
