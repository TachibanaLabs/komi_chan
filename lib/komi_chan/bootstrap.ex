defmodule KomiChan.Bootstrap do
  require Logger

  alias KomiChan.Repositories.Board
  alias KomiChan.Repositories.Thread
  alias KomiChan.Repositories.Reply
  alias Memento.Table

  def run do
    setup_tables()
    create_boards()
    create_threads()
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

  def create_threads do
    Logger.info("Adding Test Threads")
    Thread.create_thread(%Thread{title: "test title", comment: "Komi san besto wertaifu", board: "a"})
    Thread.create_thread(%Thread{title: "test title", comment: "Komi san besto wertaifu", board: "t"})
    Thread.create_thread(%Thread{title: "test title", comment: "Komi san besto wertaifu", board: "test"})
  end
end
