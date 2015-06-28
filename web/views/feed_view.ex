defmodule ElixirStream.FeedView do
  use ElixirStream.Web, :view
  alias ElixirStream.Entry
  use Timex

  def parse_markdown(markdown), do: Earmark.to_html(markdown)

  def date_format(entry) do
    {:ok, date } = entry.inserted_at
    |> Ecto.DateTime.to_iso8601
    |> DateFormat.parse("{ISOz}")
    {:ok, date} = DateFormat.format(date, "%a, %d %b %Y %H:%M:%S %z", :strftime)
    date
  end

end
