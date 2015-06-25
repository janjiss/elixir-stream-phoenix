defmodule ElixirStream.RegisterAction do
  alias ElixirStream.User
  def sign_up(params) do
    changeset = User.changeset(%User{}, params)
    if changeset.valid? do
      user = ElixirStream.Repo.insert(changeset)
      {:ok, user}
    else
      {:error, changeset}
    end
  end
end
