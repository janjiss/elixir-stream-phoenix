defmodule ElixirStream.LayoutView do
  use ElixirStream.Web, :view

  def current_user(conn) do
    conn.assigns[:current_user]
  end

  def gravatar_url_header %ElixirStream.User{email: email} do
    "https://secure.gravatar.com/avatar/#{gravatar_md5(email)}?s=40"
  end

  defp gravatar_md5(email) do
    Crypto.md5(email)
  end
end
