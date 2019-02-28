defmodule KomiChanWeb.RepliesController do
  use KomiChanWeb, :controller

  alias KomiChan.Repositories.Reply, as: ReplyRepo

  action_fallback KomiChanWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", replies: ReplyRepo.all_replies())
  end

  def show(conn, %{"id" => reply_id}) do
    found = reply_id |> String.to_integer |> ReplyRepo.find
    render(conn, "reply.json", reply: found)
  end

  def create(conn, %{"reply" => %{"comment" => comment, "board" => board, "thread" => thread}}) do
    as_model = %ReplyRepo{comment: comment, board: board, thread: thread}
    render(conn, "reply.json", reply: as_model |> ReplyRepo.create_reply())
  end
end
