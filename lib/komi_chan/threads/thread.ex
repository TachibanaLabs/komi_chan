defmodule KomiChan.Threads.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  schema "threads" do
    field :sticky, :boolean, default: false
    field :board_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:sticky])
    |> validate_required([:sticky])
  end
end
