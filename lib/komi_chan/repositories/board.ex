defmodule KomiChan.Repositories.Board do
  @moduledoc false

  use KomiChan.Repositories.Repository

  use Memento.Table,
    attributes: [:name, :description, :rules],
    type: :set

  def name(id) do
    query({:==, :name, id})
  end
end
