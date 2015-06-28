defmodule ElixirStream.EntryView do
  use ElixirStream.Web, :view
  alias ElixirStream.Entry

  def gravatar_url(%Entry{email: email}) when email != nil do
    "https://secure.gravatar.com/avatar/#{gravatar_md5(email)}?s=90"
  end

  def gravatar_url %Entry{user: %{email: email}} do
    "https://secure.gravatar.com/avatar/#{gravatar_md5(email)}?s=90"
  end

  def date_format(entry) do
    entry.inserted_at|> Ecto.DateTime.to_iso8601
  end

  def md_to_html(markdown) do
    Earmark.to_html(markdown)
    |> Phoenix.HTML.Safe.to_iodata
  end

  def gravatar_url(%Entry{email: nil}) do
    "https://secure.gravatar.com/avatar/?s=90"
  end

  def author_name(%Entry{author_name: author_name}) when author_name != nil do
    author_name
  end

  def author_name(%Entry{user: %{username: username}}) do
    username
  end

  def owner(conn, entry) do
    if ElixirStream.LayoutView.current_user(conn) do
      (entry.user_id == ElixirStream.LayoutView.current_user(conn).id)
    end
  end

  defp gravatar_md5(email) do
    Crypto.md5(email)
  end
end
