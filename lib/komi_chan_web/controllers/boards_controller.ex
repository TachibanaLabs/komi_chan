defmodule KomiChanWeb.BoardsController do
  use KomiChanWeb, :controller

  alias KomiChan.Repositories.Board, as: BoardRepo

  action_fallback KomiChanWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", boards: BoardRepo.all())
  end

  def show(conn, %{"id" => board_id}) do
    render(conn, "board.json", board: BoardRepo.find(board_id))
  end

  def create(
        conn,
        %{
          "thread" => %{
            "name" => name,
            "description" => description,
            "rules" => rules
          }
        }
      ) do
    as_model = %BoardRepo{name: name, description: description, rules: rules}

    render(
      conn,
      "board.json",
      thread: BoardRepo.create(as_model)
    )
  end
end
