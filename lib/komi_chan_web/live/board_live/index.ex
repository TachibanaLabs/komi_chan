defmodule KomiChanWeb.BoardLive.Index do
  use KomiChanWeb, :live_view

  alias KomiChan.Boards

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Boards
        <:actions>
          <.button variant="primary" navigate={~p"/boards/new"}>
            <.icon name="hero-plus" /> New Board
          </.button>
        </:actions>
      </.header>

      <.table
        id="boards"
        rows={@streams.boards}
        row_click={fn {_id, board} -> JS.navigate(~p"/boards/#{board}") end}
      >
        <:col :let={{_id, board}} label="Name">{board.name}</:col>
        <:action :let={{_id, board}}>
          <div class="sr-only">
            <.link navigate={~p"/boards/#{board}"}>Show</.link>
          </div>
          <.link navigate={~p"/boards/#{board}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, board}}>
          <.link
            phx-click={JS.push("delete", value: %{id: board.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Boards")
     |> stream(:boards, list_boards())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    board = Boards.get_board!(id)
    {:ok, _} = Boards.delete_board(board)

    {:noreply, stream_delete(socket, :boards, board)}
  end

  defp list_boards() do
    Boards.list_boards()
  end
end
