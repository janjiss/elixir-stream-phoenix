defmodule ElixirStream.CreateEntryActionForGuestUser do
  alias ElixirStream.Entry

  def persist(params, conn) do
    changeset = Entry.changeset_without_user(%Entry{}, params)
    case ReCaptcha.verify(conn) do
      :ok ->
        if changeset.valid? do
          entry = ElixirStream.Repo.insert(changeset)
          {:ok, entry}
        else
          {:error, changeset}
        end
      {:error, error} ->
        {:error, Ecto.Changeset.add_error(changeset, :captcha, "validation failed")}
    end
  end
end
