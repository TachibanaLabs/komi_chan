defmodule KomiChan.ThreadsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KomiChan.Threads` context.
  """

  @doc """
  Generate a thread.
  """
  def thread_fixture(attrs \\ %{}) do
    {:ok, thread} =
      attrs
      |> Enum.into(%{
        sticky: true
      })
      |> KomiChan.Threads.create_thread()

    thread
  end
end
