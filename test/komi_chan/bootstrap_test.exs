defmodule KomiChan.BootstrapTest do
  alias KomiChan.Repositories.{Board, Thread}

  use ExUnit.Case

  @tag :pending
  test "The seed data gets persisted on start" do
    assert Thread.all() |> length() == 3
    assert Board.all() |> length() == 3
  end
end
