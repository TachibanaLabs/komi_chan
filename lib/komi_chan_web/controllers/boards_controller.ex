defmodule KomiChanWeb.BoardsController do
  use KomiChanWeb, :controller

  alias KomiChan.Repositories.Board, as: BoardRepo

  action_fallback KomiChanWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", boards: BoardRepo.all())
  end

  def show(conn, %{"id" => name}) do
    board = name |> BoardRepo.name() |> List.first()
    render(conn, "board.json", board: board)
  end

  def create(
        conn,
        %{
          "board" => %{
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
      board: BoardRepo.create(as_model)
    )
  end
end
