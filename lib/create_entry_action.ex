defmodule ElixirStream.CreateEntryActionForExistingUser do

  alias ElixirStream.Entry

  def persist(params, user) do
    changeset = Entry.changeset_with_user(%Entry{}, params)
    if changeset.valid? do
      title = Ecto.Changeset.get_field(changeset, :title)
      entry =
        Ecto.Changeset.change(changeset, %{slug: title}) |>
        Ecto.Changeset.change(%{user_id: user.id}) |>
        ElixirStream.Repo.insert
      {:ok, entry}
    else
      {:error, changeset}
    end
  end
end
