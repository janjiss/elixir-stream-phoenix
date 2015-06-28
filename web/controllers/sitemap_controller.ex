defmodule ElixirStream.SitemapController do
  use ElixirStream.Web, :controller
  alias ElixirStream.Entry

  plug :action
  plug :accepts, ["xml"]

  def index(conn, _params) do
    entries = Repo.all from e in Entry, order_by: [desc: e.id], preload: [:user]
    conn |> render "index.xml", entries: entries
  end
end
