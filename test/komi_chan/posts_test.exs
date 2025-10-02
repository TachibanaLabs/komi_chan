defmodule KomiChan.PostsTest do
  use KomiChan.DataCase

  alias KomiChan.Posts

  describe "posts" do
    alias KomiChan.Posts.Post

    import KomiChan.PostsFixtures

    @invalid_attrs %{name: nil, text: nil, subject: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{name: "some name", text: "some text", subject: "some subject"}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.name == "some name"
      assert post.text == "some text"
      assert post.subject == "some subject"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()

      update_attrs = %{
        name: "some updated name",
        text: "some updated text",
        subject: "some updated subject"
      }

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.name == "some updated name"
      assert post.text == "some updated text"
      assert post.subject == "some updated subject"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
