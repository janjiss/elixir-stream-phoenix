defmodule ElixirStream.EntryController do
  use ElixirStream.Web, :controller

  alias ElixirStream.Entry

  plug :scrub_params, "entry" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    entries = Repo.all(Entry)
    render conn, "index.html", entries: entries
  end

  def new(conn, _params) do
    changeset = Entry.changeset(%Entry{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"entry" => entry_params}) do
    changeset = Entry.changeset(%Entry{}, entry_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Entry created successfully.")
      |> redirect(to: entry_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => id}) do
    entry = Repo.get(Entry, id)
    render conn, "show.html", entry: entry
  end

  def edit(conn, %{"id" => id}) do
    entry = Repo.get(Entry, id)
    changeset = Entry.changeset(entry)
    render conn, "edit.html", entry: entry, changeset: changeset
  end

  def update(conn, %{"id" => id, "entry" => entry_params}) do
    entry = Repo.get(Entry, id)
    changeset = Entry.changeset(entry, entry_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Entry updated successfully.")
      |> redirect(to: entry_path(conn, :index))
    else
      render conn, "edit.html", entry: entry, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    entry = Repo.get(Entry, id)
    Repo.delete(entry)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: entry_path(conn, :index))
  end
end
