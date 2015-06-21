defmodule ElixirStream.Plugs.CheckAuthentication do
  import Plug.Conn
  import Plug.Session

  def init(options) do
    options
  end

  def call(conn, _) do
    user_id = get_session(conn, :user_id)
    if is_logged_in(user_id) do
      assign(conn, :current_user, ElixirStream.Repo.get(ElixirStream.User, user_id))
    else
      conn
    end
  end

  def is_logged_in(user_session) do
    case user_session do
      nil -> false
      _   -> true
    end
  end
end

