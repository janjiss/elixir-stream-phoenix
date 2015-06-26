defmodule ElixirStream.Plugs.CheckAuthentication do
  import Plug.Conn
  import Plug.Session

  def init(options) do
    options
  end

  def call(conn, _) do
    user_id = get_session(conn, :user_id)
    if session_present?(user_id) do
      assign(conn, :current_user, ElixirStream.Repo.get(ElixirStream.User, user_id))
    else
      conn
    end
  end

  def session_present?(user_id) do
    case user_id do
      nil -> false
      _   -> true
    end
  end
end
