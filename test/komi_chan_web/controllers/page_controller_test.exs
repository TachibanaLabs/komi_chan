defmodule KomiChanWeb.PageControllerTest do
  use KomiChanWeb.ConnCase

  test "GET / redirects to boards", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert redirected_to(conn) == ~p"/boards"
  end
end
