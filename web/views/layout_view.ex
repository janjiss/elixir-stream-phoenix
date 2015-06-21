defmodule ElixirStream.LayoutView do
  use ElixirStream.Web, :view

  def current_user(conn) do
    conn.assigns[:current_user]
  end
end
