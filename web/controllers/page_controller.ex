defmodule ElixirStream.PageController do
  use ElixirStream.Web, :controller

  plug ElixirStream.Plugs.CheckAuthentication
  plug :action

  def about(conn, _params) do
    render conn, "about.html"
  end
end
