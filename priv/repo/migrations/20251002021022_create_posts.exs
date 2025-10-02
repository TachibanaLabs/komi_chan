defmodule KomiChan.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :name, :string
      add :subject, :string
      add :text, :string
      add :thread_id, references(:threads, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:posts, [:thread_id])
  end
end
