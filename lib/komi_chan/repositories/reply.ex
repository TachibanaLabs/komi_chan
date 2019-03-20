defmodule KomiChan.Repositories.Reply do
  @moduledoc false

  use KomiChan.Repositories.Repository
  use Memento.Table,
      attributes: [:id, :comment, :board, :thread, :created_at],
      index: [:board, :thread],
      autoincrement: true,
      type: :ordered_set

  def new(comment, board, thread) do
    %__MODULE__{comment: comment, board: board, thread: thread}
  end
end
