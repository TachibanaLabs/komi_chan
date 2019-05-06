defmodule KomiChan.MementoStrategy do
  @moduledoc """
  Simple handler to use Memento with ExMachina
  """
  use ExMachina.Strategy, function_name: :insert

  def handle_insert(record, _opts) do
    Memento.transaction!(fn ->
      record
      |> Memento.Query.write()
    end)
  end
end
