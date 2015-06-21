defmodule ElixirStream.CreateEntryActionForGuestUser do
  alias ElixirStream.Entry

  def persist(params) do
    changeset = Entry.changeset_without_user(%Entry{}, params)
    if changeset.valid? do
      title = Ecto.Changeset.get_field(changeset, :title)
      entry =
        Ecto.Changeset.change(changeset, %{slug: title}) |>
        ElixirStream.Repo.insert
      {:ok, entry}
    else
      {:error, changeset}
    end
  end
end
