defmodule KomiChan.Repo.Migrations.CreateThreads do
  use Ecto.Migration

  def change do
    create table(:threads) do
      add :sticky, :boolean, default: false, null: false
      add :board_id, references(:boards, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:threads, [:board_id])
  end
end
