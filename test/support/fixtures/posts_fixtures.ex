defmodule KomiChan.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KomiChan.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, board} =
      KomiChan.Boards.create_board(%{name: unique_board_name()})

    {:ok, thread} =
      KomiChan.Threads.create_thread(%{
        title: "some title",
        sticky: false,
        board_id: board.id
      })

    {:ok, post} =
      attrs
      |> Enum.into(%{
        name: "some name",
        subject: "some subject",
        text: "some text",
        thread_id: thread.id
      })
      |> KomiChan.Posts.create_post()

    post
  end

  defp unique_board_name, do: "board-#{System.unique_integer([:positive])}"
end
