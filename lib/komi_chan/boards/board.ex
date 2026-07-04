defmodule KomiChan.Boards.Board do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boards" do
    field :name, :string
    has_many :threads, KomiChan.Threads.Thread

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, max: 100)
    |> unique_constraint(:name)
  end
end
