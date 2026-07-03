defmodule KomiChanWeb.PostLiveTest do
  use KomiChanWeb.ConnCase

  import Phoenix.LiveViewTest
  import KomiChan.PostsFixtures

  defp thread_fixture_for_posts(_) do
    {:ok, board} = KomiChan.Boards.create_board(%{name: "test board"})

    {:ok, thread} =
      KomiChan.Threads.create_thread(%{title: "test thread", sticky: false, board_id: board.id})

    %{thread: thread}
  end

  defp create_post(ctx) do
    post = post_fixture()
    %{post: post, thread: ctx.thread}
  end

  describe "Index" do
    setup [:thread_fixture_for_posts, :create_post]

    test "lists all posts", %{conn: conn, post: post} do
      {:ok, _index_live, html} = live(conn, ~p"/posts")

      assert html =~ "Listing Posts"
      assert html =~ post.name
    end

    test "saves new post", %{conn: conn, thread: thread} do
      {:ok, index_live, _html} = live(conn, ~p"/posts")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Post")
               |> render_click()
               |> follow_redirect(conn, ~p"/posts/new")

      assert render(form_live) =~ "New Post"

      assert form_live
             |> form("#post-form", post: %{name: nil, text: nil, subject: nil, thread_id: nil})
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#post-form",
                 post: %{
                   name: "some name",
                   text: "some text",
                   subject: "some subject",
                   thread_id: thread.id
                 }
               )
               |> render_submit()
               |> follow_redirect(conn, ~p"/posts")

      html = render(index_live)
      assert html =~ "Post created successfully"
      assert html =~ "some name"
    end

    test "updates post in listing", %{conn: conn, post: post} do
      {:ok, index_live, _html} = live(conn, ~p"/posts")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#posts-#{post.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/posts/#{post}/edit")

      assert render(form_live) =~ "Edit Post"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#post-form",
                 post: %{
                   name: "some updated name",
                   text: "some updated text",
                   subject: "some updated subject",
                   thread_id: post.thread_id
                 }
               )
               |> render_submit()
               |> follow_redirect(conn, ~p"/posts")

      html = render(index_live)
      assert html =~ "Post updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes post in listing", %{conn: conn, post: post} do
      {:ok, index_live, _html} = live(conn, ~p"/posts")

      assert index_live |> element("#posts-#{post.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#posts-#{post.id}")
    end
  end

  describe "Show" do
    setup [:thread_fixture_for_posts, :create_post]

    test "displays post", %{conn: conn, post: post} do
      {:ok, _show_live, html} = live(conn, ~p"/posts/#{post}")

      assert html =~ "Show Post"
      assert html =~ post.name
    end

    test "updates post and returns to show", %{conn: conn, post: post} do
      {:ok, show_live, _html} = live(conn, ~p"/posts/#{post}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/posts/#{post}/edit?return_to=show")

      assert render(form_live) =~ "Edit Post"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#post-form",
                 post: %{
                   name: "some updated name",
                   text: "some updated text",
                   subject: "some updated subject",
                   thread_id: post.thread_id
                 }
               )
               |> render_submit()
               |> follow_redirect(conn, ~p"/posts/#{post}")

      html = render(show_live)
      assert html =~ "Post updated successfully"
      assert html =~ "some updated name"
    end
  end
end
