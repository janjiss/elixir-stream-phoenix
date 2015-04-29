defmodule ElixirStream.User do
  use ElixirStream.Web, :model

  schema "users" do
    field :username, :string
    field :password_digest, :string
    field :email, :string
    timestamps
  end

  @required_fields ~w(username email password_digest)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
