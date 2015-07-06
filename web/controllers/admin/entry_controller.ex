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
end
