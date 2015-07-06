defmodule ElixirStream.Admin.EntryController do
  use ElixirStream.Web, :controller
  alias ElixirStream.Entry

  def index(conn, _params) do
    entries = Repo.all from e in Entry, order_by: [desc: e.id], preload: [:user]
     conn
     |> put_layout("admin.html")
     |> render "index.html", entries: entries
  end

  def new(conn, _params) do
    changeset = Entry.changeset_with_admin(%Entry{})
    conn
    |> put_layout("admin.html")
    |> render "new.html", changeset: changeset
  end

  def create(conn, %{"entry" => entry_params}) do
    changeset = Entry.changeset_with_admin(%Entry{}, entry_params)
    if changeset.valid? do
      entry = ElixirStream.Repo.insert!(changeset)
      conn
      |> put_flash(:info, "Entry created successfully.")
      |> redirect(to: admin_entry_path(conn, :index))
    else
      conn
      |> put_layout("admin.html")
      |> render "new.html", changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    entry = Repo.one(from(e in Entry, where: e.id == ^id ))
    if entry do
      Repo.delete(entry)
      message = "Entry deleted successfully."
    else
      message = "Not found"
    end
    conn
    |> put_flash(:info, message)
    |> redirect(to: admin_entry_path(conn, :index))
  end
end
