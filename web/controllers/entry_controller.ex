defmodule ElixirStream.EntryController do
  use ElixirStream.Web, :controller
  alias ElixirStream.Entry

  plug ElixirStream.Plugs.CheckAuthentication
  plug :scrub_params, "entry" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    entries = Repo.all from e in Entry, order_by: [desc: e.id], preload: [:user]
    render conn, "index.html", entries: entries
  end

  def rss(conn, _params) do
    entries = Repo.all from e in Entry, order_by: [desc: e.id], preload: [:user]
    conn
     |> put_layout(:none)
     |> put_resp_content_type("application/rss+xml")
     |> render "index.xml", items: entries
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

  def show(conn, %{"id" => slug}) do
    entry = Repo.one(from(e in Entry, where: e.slug == ^slug, preload: [:user]))
    render conn, "show.html", entry: entry
  end

  def delete(conn, %{"id" => id}) do
    user = get_session(conn, :user_id)
    entry = Repo.one(from(e in Entry, where: e.id == ^id and e.user_id  == ^user ))
    if entry do
      Repo.delete(entry)
      message = "Entry deleted successfully."
    else
      message = "Access denied"
    end
    conn
    |> put_flash(:info, message)
    |> redirect(to: entry_path(conn, :index))
  end
end
