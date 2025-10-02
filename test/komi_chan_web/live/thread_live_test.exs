defmodule KomiChanWeb.ThreadLiveTest do
  use KomiChanWeb.ConnCase

  import Phoenix.LiveViewTest
  import KomiChan.ThreadsFixtures

  @create_attrs %{sticky: true}
  @update_attrs %{sticky: false}
  @invalid_attrs %{sticky: false}
  defp create_thread(_) do
    thread = thread_fixture()

    %{thread: thread}
  end

  describe "Index" do
    setup [:create_thread]

    test "lists all threads", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/threads")

      assert html =~ "Listing Threads"
    end

    test "saves new thread", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/threads")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Thread")
               |> render_click()
               |> follow_redirect(conn, ~p"/threads/new")

      assert render(form_live) =~ "New Thread"

      assert form_live
             |> form("#thread-form", thread: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#thread-form", thread: @create_attrs)
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

      assert form_live
             |> form("#thread-form", thread: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#thread-form", thread: @update_attrs)
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
    setup [:create_thread]

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

      assert form_live
             |> form("#thread-form", thread: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#thread-form", thread: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/threads/#{thread}")

      html = render(show_live)
      assert html =~ "Thread updated successfully"
    end
  end
end
