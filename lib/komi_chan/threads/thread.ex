defmodule KomiChan.Threads.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  schema "threads" do
    field :title, :string
    field :sticky, :boolean, default: false
    belongs_to :board, KomiChan.Boards.Board
    has_many :posts, KomiChan.Posts.Post

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:title, :sticky, :board_id])
    |> validate_required([:title, :sticky, :board_id])
    |> validate_length(:title, max: 200)
  end
end
