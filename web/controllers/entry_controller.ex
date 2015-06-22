defmodule ElixirStream.EntryController do
  use ElixirStream.Web, :controller
  alias ElixirStream.Entry

  plug ElixirStream.Plugs.CheckAuthentication
  plug :scrub_params, "entry" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    entries = Repo.all from p in Entry, preload: [:user]
    render conn, "index.html", entries: entries
  end

  def new(conn, _params) do
    changeset = Entry.changeset_with_user(%Entry{})
    render conn, "new.html", changeset: changeset
  end

  def create(%Plug.Conn{assigns: %{current_user: current_user}} = conn, %{"entry" => entry_params}) do
    case ElixirStream.CreateEntryActionForExistingUser.persist(entry_params, current_user) do
      {:ok, %Entry{} = entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: entry_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def create(conn, %{"entry" => entry_params}) do
    case ElixirStream.CreateEntryActionForGuestUser.persist(entry_params) do
      {:ok, %Entry{} = entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: entry_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => id}) do
    entry = Repo.one(from(e in Entry, where: e.id == ^id, preload: [:user]))
    render conn, "show.html", entry: entry
  end

  def delete(conn, %{"id" => id}) do
    entry = Repo.get(Entry, id)
    Repo.delete(entry)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: entry_path(conn, :index))
  end
end
