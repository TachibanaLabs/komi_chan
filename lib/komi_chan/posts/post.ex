defmodule KomiChan.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :name, :string
    field :subject, :string
    field :text, :string
    belongs_to :thread, KomiChan.Threads.Thread

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:name, :subject, :text, :thread_id])
    |> validate_required([:name, :subject, :text, :thread_id])
    |> validate_length(:name, max: 100)
    |> validate_length(:subject, max: 200)
    |> validate_length(:text, max: 5000)
  end
end
