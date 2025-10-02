defmodule KomiChan.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KomiChan.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        name: "some name",
        subject: "some subject",
        text: "some text"
      })
      |> KomiChan.Posts.create_post()

    post
  end
end
