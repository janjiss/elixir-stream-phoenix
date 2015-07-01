defmodule ElixirStream.FeedController do
  use ElixirStream.Web, :controller
  alias ElixirStream.Entry

  def index(conn, _params) do
    entries = Repo.all from e in Entry, order_by: [desc: e.id], preload: [:user]
    conn
     |> put_layout(:none)
     |> put_resp_content_type("application/xml")
     |> render "index.xml", items: entries
  end
end
