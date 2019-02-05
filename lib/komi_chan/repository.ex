defmodule KomiChan.Repository.Thread do
  @store __MODULE__

  use Memento.Table,
    attributes: [:id, :message, :created_at, :updated_at, :replies],
    autoincrement: true,
    type: :ordered_set

  def new(message) do
    %@store{message: message}
  end

  def find(id) do
    Memento.transaction!(fn ->
      Memento.Query.read(@store, id)
    end)
  end

  def all_threads do
    run_query([])
  end

  def create_thread(thread) do
    thread
    |> Map.put(:created_at, NaiveDateTime.utc_now())
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
end
