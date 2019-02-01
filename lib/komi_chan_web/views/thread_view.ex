defmodule KomiChanWeb.ThreadView do
  use KomiChanWeb, :view

  alias KomiChanWeb.ThreadView

  def render("index.json", %{threads: threads}) do
    %{threads: render_many(threads, ThreadView, "thread.json")}
  end

  def render("thread.json", %{thread: thread}) do
    %{id: thread.id, message: thread.message}
  end
end
