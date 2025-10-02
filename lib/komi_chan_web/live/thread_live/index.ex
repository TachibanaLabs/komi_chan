defmodule KomiChanWeb.ThreadLive.Index do
  use KomiChanWeb, :live_view

  alias KomiChan.Threads

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Threads
        <:actions>
          <.button variant="primary" navigate={~p"/threads/new"}>
            <.icon name="hero-plus" /> New Thread
          </.button>
        </:actions>
      </.header>

      <.table
        id="threads"
        rows={@streams.threads}
        row_click={fn {_id, thread} -> JS.navigate(~p"/threads/#{thread}") end}
      >
        <:col :let={{_id, thread}} label="Sticky">{thread.sticky}</:col>
        <:action :let={{_id, thread}}>
          <div class="sr-only">
            <.link navigate={~p"/threads/#{thread}"}>Show</.link>
          </div>
          <.link navigate={~p"/threads/#{thread}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, thread}}>
          <.link
            phx-click={JS.push("delete", value: %{id: thread.id}) |> hide("##{id}")}
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
     |> assign(:page_title, "Listing Threads")
     |> stream(:threads, list_threads())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    thread = Threads.get_thread!(id)
    {:ok, _} = Threads.delete_thread(thread)

    {:noreply, stream_delete(socket, :threads, thread)}
  end

  defp list_threads() do
    Threads.list_threads()
  end
end
