defmodule KomiChan.Repositories.Thread do
  @moduledoc false

  use KomiChan.Repositories.Repository
  use Memento.Table,
      attributes: [:id, :title, :comment, :board, :created_at, :updated_at],
      index: [:board],
      autoincrement: true,
      type: :ordered_set

  def all_on_board(board) do
    query({:==, :board, board})
  end
end
