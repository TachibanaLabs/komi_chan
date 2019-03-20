defmodule KomiChanWeb.BoardsView do
  use KomiChanWeb, :view

  alias KomiChan.Repositories.Board
  alias KomiChanWeb.BoardsView

  def render("index.json", %{boards: boards}) do
    %{boards: render_many(boards, BoardsView, "board.json", as: :board)}
  end

  def render("board.json", %{board: board = %Board{}}) do
    %{
      description: board.description,
      name: board.name,
      rules: board.rules
    }
  end

  def render("board.json", %{board: _board}) do
    %{error: "Not Found"}
  end
end
