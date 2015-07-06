defmodule ElixirStream.Admin.EntryView do
  use ElixirStream.Web, :view
  alias ElixirStream.Entry
  alias ElixirStream.User
  alias ElixirStream.Repo


  def all_users do
    import Ecto.Query, only: [from: 2]
    Repo.all(from(u in User, select: {u.username, u.id} ) )
  end

  def author_name(%Entry{author_name: author_name}) when author_name != nil do
    author_name
  end

  def author_name(%Entry{user: %{username: username}}) do
    username
  end

  def owner(conn, entry) do
    if ElixirStream.LayoutView.current_user(conn) do
      (entry.user_id == ElixirStream.LayoutView.current_user(conn).id)
    end
  end

end
