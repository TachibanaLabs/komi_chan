defmodule KomiChan.Repositories.Repository do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @store __MODULE__

      def normalize_id(id), do: id

      def normalize_id(id) when is_binary(id) do
        String.to_integer(id)
      end

      def find(id) do
        Memento.transaction!(fn ->
          Memento.Query.read(@store, normalize_id(id))
        end)
      end

      def all do
        query([])
      end

      def create(model) do
        model
        |> Map.put(:created_at, NaiveDateTime.utc_now())
        |> update
      end

      def update(model) do
        Memento.transaction!(fn ->
          model
          |> Map.put(:updated_at, NaiveDateTime.utc_now())
          |> Memento.Query.write()
        end)
      end

      def query(pattern) do
        Memento.transaction!(fn ->
          @store
          |> Memento.Query.select(pattern)
        end)
      end
    end
  end
end
