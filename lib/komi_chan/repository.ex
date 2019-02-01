defmodule KomiChan.Repository do
  @moduledoc false

  defmodule Threads do
    @moduledoc false
    @store __MODULE__

    use Memento.Table,
      attributes: [:id, :message, :created_at, :updated_at],
      autoincrement: true,
      type: :ordered_set

    def all_threads do
      run_query([])
    end

    def create_thread(thread) do
      thread
      |> Map.put(:created_at, NaiveDateTime.utc_now())
      |> to_db_job
      |> update_thread
    end

    def update_thread(thread) do
      Memento.transaction!(fn ->
        thread
        |> Map.put(:updated_at, NaiveDateTime.utc_now())
        |> Memento.Query.write()
      end)
    end

    defp run_query(pattern) do
      Memento.transaction!(fn ->
        @store
        |> Memento.Query.select(pattern)
      end)
    end

    def test(message) do
      KomiChan.Repository.Threads.create_thread(KomiChan.Model.Thread.new(message))
    end

    def launch do
      Memento.Table.create(KomiChan.Repository.Threads)
    end

    # Convert Que.Job to Mnesia Job
    defp to_db_job(%KomiChan.Model.Thread{} = thread) do
      struct(@store, Map.from_struct(thread))
    end
  end
end
