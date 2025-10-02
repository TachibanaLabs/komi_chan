defmodule KomiChanWeb.BoardLiveTest do
  use KomiChanWeb.ConnCase

  import Phoenix.LiveViewTest
  import KomiChan.BoardsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}
  defp create_board(_) do
    board = board_fixture()

    %{board: board}
  end

  describe "Index" do
    setup [:create_board]

    test "lists all boards", %{conn: conn, board: board} do
      {:ok, _index_live, html} = live(conn, ~p"/boards")

      assert html =~ "Listing Boards"
      assert html =~ board.name
    end

    test "saves new board", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/boards")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Board")
               |> render_click()
               |> follow_redirect(conn, ~p"/boards/new")

      assert render(form_live) =~ "New Board"

      assert form_live
             |> form("#board-form", board: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#board-form", board: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/boards")

      html = render(index_live)
      assert html =~ "Board created successfully"
      assert html =~ "some name"
    end

    test "updates board in listing", %{conn: conn, board: board} do
      {:ok, index_live, _html} = live(conn, ~p"/boards")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#boards-#{board.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/boards/#{board}/edit")

      assert render(form_live) =~ "Edit Board"

      assert form_live
             |> form("#board-form", board: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#board-form", board: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/boards")

      html = render(index_live)
      assert html =~ "Board updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes board in listing", %{conn: conn, board: board} do
      {:ok, index_live, _html} = live(conn, ~p"/boards")

      assert index_live |> element("#boards-#{board.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#boards-#{board.id}")
    end
  end

  describe "Show" do
    setup [:create_board]

    test "displays board", %{conn: conn, board: board} do
      {:ok, _show_live, html} = live(conn, ~p"/boards/#{board}")

      assert html =~ "Show Board"
      assert html =~ board.name
    end

    test "updates board and returns to show", %{conn: conn, board: board} do
      {:ok, show_live, _html} = live(conn, ~p"/boards/#{board}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/boards/#{board}/edit?return_to=show")

      assert render(form_live) =~ "Edit Board"

      assert form_live
             |> form("#board-form", board: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#board-form", board: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/boards/#{board}")

      html = render(show_live)
      assert html =~ "Board updated successfully"
      assert html =~ "some updated name"
    end
  end
end
