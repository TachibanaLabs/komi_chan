defmodule KomiChan.ThreadsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KomiChan.Threads` context.
  """

  @doc """
  Generate a thread.
  """
  def thread_fixture(attrs \\ %{}) do
    {:ok, board} =
      KomiChan.Boards.create_board(%{name: unique_board_name()})

    {:ok, thread} =
      attrs
      |> Enum.into(%{
        title: "some title",
        sticky: true,
        board_id: board.id
      })
      |> KomiChan.Threads.create_thread()

    thread
  end

  defp unique_board_name, do: "board-#{System.unique_integer([:positive])}"
end
