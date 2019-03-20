defmodule KomiChan.Bootstrap do
  @moduledoc """
  Creates Mnesia tables and some seed rows
  """

  require Logger

  alias KomiChan.Repositories.Board
  alias KomiChan.Repositories.Reply
  alias KomiChan.Repositories.Thread
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
    Board.create(%Board{name: "t", description: "test", rules: "none"})
    Board.create(%Board{name: "a", description: "animemes", rules: "none"})
    Board.create(%Board{name: "test", description: "another test", rules: "none"})
  end

  def create_threads do
    Logger.info("Adding Test Threads")
    Thread.create(%Thread{title: "test title", comment: "Komi san besto wertaifu", board: "a"})
    Thread.create(%Thread{title: "test title", comment: "Komi san besto wertaifu", board: "t"})
    Thread.create(%Thread{title: "test title", comment: "Komi san besto wertaifu", board: "test"})
  end
end
