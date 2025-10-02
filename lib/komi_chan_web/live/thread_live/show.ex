defmodule KomiChanWeb.ThreadLive.Show do
  use KomiChanWeb, :live_view

  alias KomiChan.Threads

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Thread {@thread.id}
        <:subtitle>This is a thread record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/threads"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/threads/#{@thread}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit thread
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Sticky">{@thread.sticky}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Thread")
     |> assign(:thread, Threads.get_thread!(id))}
  end
end
