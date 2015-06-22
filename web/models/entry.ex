defmodule ElixirStream.Entry do
  use ElixirStream.Web, :model
  use Ecto.Model.Callbacks
  alias ElixirStream.User

  before_insert :set_slug

  schema "entries" do
    field :email, :string
    field :author_name, :string
    field :title, :string
    field :body, :string
    field :slug, :string
    belongs_to :user, User
    timestamps
  end

  @optional_fields ~w(email author_name)
  @required_fields ~w(title body)

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

  def set_slug(changeset) do
    title = Ecto.Changeset.get_field(changeset, :title) |>
    String.strip |> String.replace(" ", "_") |> String.downcase
    change(changeset, %{slug: title})
  end
end
