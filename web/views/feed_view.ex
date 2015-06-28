defmodule ElixirStream.FeedView do
  use ElixirStream.Web, :view
  alias ElixirStream.Entry

  def markdown_to_html(markdown), do: Earmark.to_html(markdown)

  def markdown_to_html_safe(markdown)  do
    {:safe, html} = markdown_to_html(markdown) |> html_escape
    html
  end

  def date_format(entry) do
    entry.inserted_at |> Ecto.DateTime.to_iso8601
  end

end
