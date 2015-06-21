defmodule ElixirStream.User do
  use ElixirStream.Web, :model
  alias ElixirStream.Repo

  schema "users" do
    field :username, :string
    field :password_digest, :string
    field :email, :string
    field :password, :string, virtual: true
    timestamps
  end

  @required_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid chageset is returned
  with no validation performed.
  """

  def changeset(user, params \\ nil) do
    user
    |> cast(params, ~w(username email password))
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:username, min: 5)
    |> validate_length(:username, max: 50)
    |> validate_length(:password, min: 8)
    |> validate_length(:password, max: 100)
    |> validate_unique(:email, on: Repo)
    |> validate_unique(:username, on: Repo)
  end

end
