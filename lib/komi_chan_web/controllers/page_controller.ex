defmodule KomiChanWeb.PageController do
  use KomiChanWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
