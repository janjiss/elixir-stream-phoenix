defmodule ElixirStream.Entry do
  use ElixirStream.Web, :model
  alias ElixirStream.User

  schema "entries" do
    field :email, :string
    field :author_name, :string
    field :title, :string
    field :body, :string
    field :slug, :string

    belongs_to :user, User


    timestamps
  end

  @required_fields ~w(title body)
  @optional_fields ~w(email author_name)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset_without_user(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:author_name, min: 5)
    |> validate_length(:title, min: 5)
    |> validate_length(:body, min: 15)
    |> validate_length(:body, max: 500)
  end

  def changeset_with_user(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:title, min: 5)
    |> validate_length(:body, min: 15)
    |> validate_length(:body, max: 500)
  end
end
