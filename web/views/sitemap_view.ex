defmodule ElixirStream.SitemapView do
  use ElixirStream.Web, :view
  alias ElixirStream.Entry

  def date_format(entry) do
    entry.inserted_at |> Ecto.DateTime.to_iso8601
  end

  def last_update_date(collection) do
    List.first(collection) |> date_format 
  end
end
