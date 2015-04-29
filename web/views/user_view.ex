defmodule ElixirStream.UserView do
  use ElixirStream.Web, :view
  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", users: users
  end
end
