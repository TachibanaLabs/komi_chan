defmodule KomiChanWeb.ThreadLiveTest do
  use KomiChanWeb.ConnCase

  import Phoenix.LiveViewTest
  import KomiChan.ThreadsFixtures
  import KomiChan.BoardsFixtures

  defp board_fixture_for_threads(_) do
    board = board_fixture()
    %{board: board}
  end

  defp create_thread(ctx) do
    thread = thread_fixture()
    %{thread: thread, board: ctx.board}
  end

  describe "Index" do
    setup [:board_fixture_for_threads, :create_thread]

    test "lists all threads", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/threads")

      assert html =~ "Listing Threads"
    end

    test "saves new thread", %{conn: conn, board: board} do
      {:ok, index_live, _html} = live(conn, ~p"/threads")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Thread")
               |> render_click()
               |> follow_redirect(conn, ~p"/threads/new")

      assert render(form_live) =~ "New Thread"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#thread-form",
                 thread: %{title: "some title", sticky: true, board_id: board.id}
               )
               |> render_submit()
               |> follow_redirect(conn, ~p"/threads")

      html = render(index_live)
      assert html =~ "Thread created successfully"
    end

    test "updates thread in listing", %{conn: conn, thread: thread} do
      {:ok, index_live, _html} = live(conn, ~p"/threads")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#threads-#{thread.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/threads/#{thread}/edit")

      assert render(form_live) =~ "Edit Thread"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#thread-form", thread: %{title: "updated title", sticky: false})
               |> render_submit()
               |> follow_redirect(conn, ~p"/threads")

      html = render(index_live)
      assert html =~ "Thread updated successfully"
    end

    test "deletes thread in listing", %{conn: conn, thread: thread} do
      {:ok, index_live, _html} = live(conn, ~p"/threads")

      assert index_live |> element("#threads-#{thread.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#threads-#{thread.id}")
    end
  end

  describe "Show" do
    setup [:board_fixture_for_threads, :create_thread]

    test "displays thread", %{conn: conn, thread: thread} do
      {:ok, _show_live, html} = live(conn, ~p"/threads/#{thread}")

      assert html =~ "Show Thread"
    end

    test "updates thread and returns to show", %{conn: conn, thread: thread} do
      {:ok, show_live, _html} = live(conn, ~p"/threads/#{thread}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/threads/#{thread}/edit?return_to=show")

      assert render(form_live) =~ "Edit Thread"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#thread-form", thread: %{title: "updated title", sticky: false})
               |> render_submit()
               |> follow_redirect(conn, ~p"/threads/#{thread}")

      html = render(show_live)
      assert html =~ "Thread updated successfully"
    end
  end
end
