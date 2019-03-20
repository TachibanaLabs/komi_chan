defmodule KomiChanWeb.BoardsView do
  use KomiChanWeb, :view

  alias KomiChan.Repositories.Board, as: BoardRepo
  alias KomiChanWeb.ThreadsView

  def render("index.json", %{boards: boards}) do
    %{boards: render_many(boards, ThreadsView, "board.json", as: :board)}
  end

  def render("board.json", %{board: board = %BoardRepo{}}) do
    %{
      id: board.id,
      title: board.title,
      comment: board.comment,
      board: board.board,
      created_at: board.created_at
    }
  end

  def render("board.json", %{board: _board}) do
    %{error: "Not Found"}
  end
end
