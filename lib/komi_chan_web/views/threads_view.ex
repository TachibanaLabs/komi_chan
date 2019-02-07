defmodule KomiChanWeb.ThreadsView do
  use KomiChanWeb, :view

  alias KomiChanWeb.ThreadsView

  def render("index.json", %{threads: threads}) do
    %{threads: render_many(threads, ThreadsView, "thread.json", as: :thread)}
  end

  def render("thread.json", %{thread: thread}) do
    case thread do
      nil -> %{error: "Not Found"}
      _ -> %{id: thread.id, title: thread.title, comment: thread.comment, board: thread.board, created_at: thread.created_at}
    end
  end
end
