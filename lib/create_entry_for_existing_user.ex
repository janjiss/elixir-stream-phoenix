defmodule ElixirStream.CreateEntryActionForExistingUser do

  alias ElixirStream.Entry

  def persist(params, user) do
    changeset = Entry.changeset_with_user(%Entry{}, params)
    if changeset.valid? do
      entry =
        Ecto.Changeset.change(%{user_id: user.id}) |>
        ElixirStream.Repo.insert
      {:ok, entry}
    else
      {:error, changeset}
    end
  end
end
