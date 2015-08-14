defmodule ElixirStream.Admin.EntryController do
  use ElixirStream.Web, :controller
  alias ElixirStream.Entry

  plug PlugBasicAuth,
    username: Application.get_env(:basic_auth, :username),
    password: Application.get_env(:basic_auth, :password)

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

  def edit(conn, %{"id" => id}) do
    entry = Repo.one(from(e in Entry, where: e.slug == ^id ))
    changeset = Entry.changeset_with_admin(entry)

    conn
    |> put_layout("admin.html")
    |> render "edit.html", entry: entry, changeset: changeset
  end

  def update(conn, %{"id" => id, "entry" => entry_params}) do
    entry = Repo.one(from(e in Entry, where: e.id == ^id ))
    changeset = Entry.changeset_with_admin(entry, entry_params)

    if changeset.valid? do
      Repo.update(changeset)
      conn
      |> put_flash(:info, "Entry updated successfully.")
      |> redirect(to: admin_entry_path(conn, :index))
    else
      render(conn, "edit.html", entry: entry, changeset: changeset)
    end
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

  def tweeted(conn, %{"id" => id}) do
      entry = Repo.one(from(e in Entry, where: e.id == ^id and e.tweet_posted == false))
      if ElixirStream.Tweeted.tweeted(entry) do
        message = "Entry Tweeted"
      else
        message = "Entry Not Tweeted"
      end

      conn
      |> put_flash(:info, message)
      |> redirect(to: admin_entry_path(conn, :index))
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
