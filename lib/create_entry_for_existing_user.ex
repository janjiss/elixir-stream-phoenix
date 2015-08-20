defmodule ElixirStream.CreateEntryActionForExistingUser do
  alias ElixirStream.Entry
  alias ElixirStream.ReCaptcha

  def persist(params, user, conn) do
    changeset = Entry.changeset_with_user(%Entry{}, params)
    case ReCaptcha.verify(conn) do
      :ok ->
        if changeset.valid? do
          Ecto.Changeset.change(changeset, %{user_id: user.id}) |>
          ElixirStream.Repo.insert
        else
          {:error, changeset}
        end
      {:error, error} ->
        {:error, Ecto.Changeset.add_error(changeset, :captcha, "validation failed")}
    end
  end
end
