defmodule ElixirStream.RegisterAction do
  alias ElixirStream.User
  def sign_up(params) do
    changeset = User.changeset(%User{}, params)
    if changeset.valid? do
      password = Ecto.Changeset.get_field(changeset, :password)
      user = Ecto.Changeset.change(changeset, %{password_digest: crypt_password(password)}) |>
      ElixirStream.Repo.insert
      {:ok, user}
    else
      {:error, changeset}
    end
  end

  def crypt_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

end
