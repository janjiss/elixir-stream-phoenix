defmodule ElixirStream.EntryView do
  use ElixirStream.Web, :view
  alias ElixirStream.Entry

  def gravatar_url(%Entry{email: email}) when email != nil do
    "https://secure.gravatar.com/avatar/#{gravatar_md5(email)}?s=90"
  end

  def gravatar_url %Entry{user: %{email: email}} do
    "https://secure.gravatar.com/avatar/#{gravatar_md5(email)}?s=90"
  end

  def gravatar_url(%Entry{email: nil}) do
    "https://secure.gravatar.com/avatar/?s=90"
  end

  def current_user(conn) do
    conn.assigns[:current_user]
  end

  def author_name(%Entry{author_name: author_name}) when author_name != nil do
    author_name
  end

  def author_name(%Entry{user: %{username: username}}) do
    username
  end

  def owner(conn, entry) do
    if current_user(conn) do
      (entry.user_id == current_user(conn).id)
    end
  end


  defp gravatar_md5(email) do
    Crypto.md5(email)
  end
end
