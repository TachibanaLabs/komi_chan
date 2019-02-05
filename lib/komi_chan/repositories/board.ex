defmodule KomiChan.Repositories.Board do
  @store __MODULE__

  use Memento.Table,
      attributes: [:name, :description, :rules],
      type: :set

  def find(id) do
    Memento.transaction!(
      fn ->
        Memento.Query.read(@store, id)
      end
    )
  end

  def all_boards do
    run_query([])
  end

  def create_board(board) do
    Memento.transaction!(
      fn ->
        board
        |> Memento.Query.write()
      end
    )
  end

  defp run_query(pattern) do
    Memento.transaction!(
      fn ->
        @store
        |> Memento.Query.select(pattern)
      end
    )
  end
end
