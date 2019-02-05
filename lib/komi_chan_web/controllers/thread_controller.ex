defmodule KomiChanWeb.ThreadController do
  use KomiChanWeb, :controller

  alias KomiChan.Repository.Thread, as: ThreadRepo

  action_fallback KomiChanWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", threads: ThreadRepo.all_threads())
  end

  def show(conn, %{"id" => thread_id}) do
    render(conn, "thread.json", thread: ThreadRepo.find(thread_id))
  end

  def create(conn, %{"message" => message}) do
    render(conn, "thread.json", thread: ThreadRepo.new(message) |> ThreadRepo.create_thread())
  end
end
