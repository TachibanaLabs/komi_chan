defmodule KomiChan.Repo.Migrations.FixDataIntegrity do
  use Ecto.Migration

  def change do
    create unique_index(:boards, [:name])

    alter table(:threads) do
      add :title, :string
    end

    drop constraint(:threads, "threads_board_id_fkey")

    alter table(:threads) do
      modify :board_id, references(:boards, on_delete: :delete_all)
    end

    alter table(:posts) do
      modify :text, :text, from: :string
    end

    drop constraint(:posts, "posts_thread_id_fkey")

    alter table(:posts) do
      modify :thread_id, references(:threads, on_delete: :delete_all)
    end
  end
end
