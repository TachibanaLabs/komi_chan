defmodule KomiChanWeb.ThreadsControllerTest do
  use KomiChanWeb.ConnCase

  alias KomiChan.Repositories.Thread

  describe "index/2" do
    test "Lists all the threads", %{conn: conn} do
      response =
        conn
        |> get(Routes.threads_path(conn, :index))
        |> json_response(200)

      total_threads =
        response["threads"]
        |> length()

      total_from_db =
        Thread.all()
        |> length()

      assert total_threads == total_from_db
    end
  end

  describe "show/2" do
    test "Lists a single thread", %{conn: conn} do
      thread = Thread.find(1)

      response =
        conn
        |> get(Routes.threads_path(conn, :show, thread.id))
        |> json_response(200)

      title = response["title"]

      assert thread.title == title
    end
  end

  describe "create/2" do
    test "Creates a new thread", %{conn: conn} do
      params = %{"title" => "test", "comment" => "test", "board" => "a"}

      response =
        conn
        |> post(Routes.threads_path(conn, :create, %{"thread" => params}))
        |> json_response(200)

      assert params["title"] == response["title"]
      assert response["created_at"]
    end
  end
end
