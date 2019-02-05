defmodule KomiChan.Repositories.Reply do
  @store __MODULE__

  use Memento.Table,
    attributes: [:id, :comment, :board, :thread, :created_at],
    index: [:board, :thread],
    autoincrement: true,
    type: :ordered_set

  def new(comment, board, thread) do
    %@store{comment: comment, board: board, thread: thread}
  end

  def find(id) do
    Memento.transaction!(fn ->
      Memento.Query.read(@store, id)
    end)
  end

  def all_replies do
    run_query([])
  end

  def create_reply(reply) do
    Memento.transaction!(
      fn ->
        reply
        |> Map.put(:created_at, NaiveDateTime.utc_now())
        |> Memento.Query.write()
      end
    )
  end

  defp run_query(pattern) do
    Memento.transaction!(fn ->
      @store
      |> Memento.Query.select(pattern)
    end)
  end
end
