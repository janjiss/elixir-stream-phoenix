defmodule ElixirStream.EntryView do
  use ElixirStream.Web, :view
  alias ElixirStream.Entry

  def current_user(conn) do
    conn.assigns[:current_user]
  end

  def gravatar_url(%Entry{email: email}) when email != nil do
    "https://secure.gravatar.com/avatar/#{gravatar_md5(email)}?s=70"
  end

  def gravatar_url %Entry{user: %{email: email}} do
    "https://secure.gravatar.com/avatar/#{gravatar_md5(email)}?s=70"
  end

  def author_name(%Entry{author_name: author_name}) when author_name != nil do
    author_name
  end

  def author_name(%Entry{user: %{username: username}}) do
    username
  end

  defp gravatar_md5(email) do
    Crypto.md5(email)
  end
end
