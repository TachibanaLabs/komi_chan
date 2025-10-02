defmodule KomiChan.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
