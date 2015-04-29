defmodule ElixirStream.PageController do
  use ElixirStream.Web, :controller

  plug :action

  def about(conn, _params) do
    render conn, "about.html"
  end
end
