defmodule KomiChanWeb.BoardsControllerTest do
  use KomiChanWeb.ConnCase

  alias KomiChan.Repositories.Board

  describe "index/2" do
    test "Lists all the boards", %{conn: conn} do
      response =
        conn
        |> get(Routes.boards_path(conn, :index))
        |> json_response(200)

      total_boards =
        response["boards"]
        |> length()

      total_from_db =
        Board.all()
        |> length()

      assert total_boards == total_from_db
    end
  end

  describe "show/2" do
    test "Lists a single board", %{conn: conn} do
      board =
        Board.name("a")
        |> List.first()

      response =
        conn
        |> get(Routes.boards_path(conn, :show, board.name))
        |> json_response(200)

      description = response["description"]

      assert board.description == description
    end
  end

  describe "create/2" do
    test "Creates a new board", %{conn: conn} do
      params = %{"name" => "tps", "description" => "test", "rules" => "none"}

      response =
        conn
        |> post(Routes.boards_path(conn, :create, %{"board" => params}))
        |> json_response(200)

      assert params == response
    end
  end
end
