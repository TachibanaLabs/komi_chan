defmodule KomiChan.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :name, :string
    field :subject, :string
    field :text, :string
    field :thread_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:name, :subject, :text])
    |> validate_required([:name, :subject, :text])
  end
end
