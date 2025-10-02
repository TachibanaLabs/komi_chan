defmodule KomiChanWeb.BoardLive.Show do
  use KomiChanWeb, :live_view

  alias KomiChan.Boards

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Board {@board.id}
        <:subtitle>This is a board record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/boards"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/boards/#{@board}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit board
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Name">{@board.name}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Board")
     |> assign(:board, Boards.get_board!(id))}
  end
end
