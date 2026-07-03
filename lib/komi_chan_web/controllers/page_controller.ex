defmodule KomiChanWeb.PageController do
  use KomiChanWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: ~p"/boards")
  end
end
