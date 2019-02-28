defmodule KomiChanWeb.ThreadsView do
  use KomiChanWeb, :view

  alias KomiChan.Repositories.Thread, as: ThreadRepo
  alias KomiChanWeb.ThreadsView

  def render("index.json", %{threads: threads}) do
    %{threads: render_many(threads, ThreadsView, "thread.json", as: :thread)}
  end

  def render("thread.json", %{thread: thread = %ThreadRepo{}}) do
    %{id: thread.id, title: thread.title, comment: thread.comment, board: thread.board, created_at: thread.created_at}
  end

  def render("thread.json", %{thread: _thread}) do
    %{error: "Not Found"}
  end
end
