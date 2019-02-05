defmodule KomiChan.Bootstrap do
  require Logger

  alias KomiChan.Repositories.Board, as: Board
  alias KomiChan.Repositories.Thread, as: Thread
  alias KomiChan.Repositories.Reply, as: Reply
  alias Memento.Table, as: Table

  def run do
    setup_tables()
    create_boards()
  end

  def setup_tables do
    Logger.info("Creating Mnesia Tables")
    Table.create(Board)
    Table.create(Thread)
    Table.create(Reply)
  end

  def create_boards do
    Logger.info("Adding Test Boards")
    Board.create_board(%Board{name: "t", description: "test", rules: "none"})
    Board.create_board(%Board{name: "a", description: "animemes", rules: "none"})
    Board.create_board(%Board{name: "test", description: "another test", rules: "none"})
  end
end
