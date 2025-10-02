defmodule KomiChanWeb.BoardLive.Form do
  use KomiChanWeb, :live_view

  alias KomiChan.Boards
  alias KomiChan.Boards.Board

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage board records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="board-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:name]} type="text" label="Name" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Board</.button>
          <.button navigate={return_path(@return_to, @board)}>Cancel</.button>
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
    board = Boards.get_board!(id)

    socket
    |> assign(:page_title, "Edit Board")
    |> assign(:board, board)
    |> assign(:form, to_form(Boards.change_board(board)))
  end

  defp apply_action(socket, :new, _params) do
    board = %Board{}

    socket
    |> assign(:page_title, "New Board")
    |> assign(:board, board)
    |> assign(:form, to_form(Boards.change_board(board)))
  end

  @impl true
  def handle_event("validate", %{"board" => board_params}, socket) do
    changeset = Boards.change_board(socket.assigns.board, board_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"board" => board_params}, socket) do
    save_board(socket, socket.assigns.live_action, board_params)
  end

  defp save_board(socket, :edit, board_params) do
    case Boards.update_board(socket.assigns.board, board_params) do
      {:ok, board} ->
        {:noreply,
         socket
         |> put_flash(:info, "Board updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, board))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_board(socket, :new, board_params) do
    case Boards.create_board(board_params) do
      {:ok, board} ->
        {:noreply,
         socket
         |> put_flash(:info, "Board created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, board))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _board), do: ~p"/boards"
  defp return_path("show", board), do: ~p"/boards/#{board}"
end
