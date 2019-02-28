defmodule KomiChanWeb.BoardsController do
  use KomiChanWeb, :controller

  alias KomiChan.Repositories.Board, as: BoardRepo

  action_fallback KomiChanWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", boards: BoardRepo.all_boards())
  end

  def show(conn, %{"id" => board_id}) do
    found = board_id |> String.to_integer |> BoardRepo.find
    render(conn, "board.json", board: found)
  end

  def create(conn, %{"thread" => %{"name" => name, "description" => description, "rules" => rules}}) do
    as_model = %BoardRepo{name: name, description: description, rules: rules}
    render(conn, "board.json", thread: as_model |> BoardRepo.create_board())
  end
end
