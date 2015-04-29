defmodule ElixirStream.EntryView do
  use ElixirStream.Web, :view

  def gravatar_url(email) do
    "https://secure.gravatar.com/avatar/#{gravatar_md5(email)}?s=70"
  end

  defp gravatar_md5(email) do
    Crypto.md5(email)
  end
end
