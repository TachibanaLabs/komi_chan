defmodule KomiChanWeb.ThreadLive.Form do
  use KomiChanWeb, :live_view

  alias KomiChan.Threads
  alias KomiChan.Threads.Thread

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage thread records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="thread-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:sticky]} type="checkbox" label="Sticky" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Thread</.button>
          <.button navigate={return_path(@return_to, @thread)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    thread = Threads.get_thread!(id)

    socket
    |> assign(:page_title, "Edit Thread")
    |> assign(:thread, thread)
    |> assign(:form, to_form(Threads.change_thread(thread)))
  end

  defp apply_action(socket, :new, _params) do
    thread = %Thread{}

    socket
    |> assign(:page_title, "New Thread")
    |> assign(:thread, thread)
    |> assign(:form, to_form(Threads.change_thread(thread)))
  end

  @impl true
  def handle_event("validate", %{"thread" => thread_params}, socket) do
    changeset = Threads.change_thread(socket.assigns.thread, thread_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"thread" => thread_params}, socket) do
    save_thread(socket, socket.assigns.live_action, thread_params)
  end

  defp save_thread(socket, :edit, thread_params) do
    case Threads.update_thread(socket.assigns.thread, thread_params) do
      {:ok, thread} ->
        {:noreply,
         socket
         |> put_flash(:info, "Thread updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, thread))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_thread(socket, :new, thread_params) do
    case Threads.create_thread(thread_params) do
      {:ok, thread} ->
        {:noreply,
         socket
         |> put_flash(:info, "Thread created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, thread))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _thread), do: ~p"/threads"
  defp return_path("show", thread), do: ~p"/threads/#{thread}"
end
