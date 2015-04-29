defmodule ElixirStream.Entry do
  use ElixirStream.Web, :model

  schema "entries" do
    field :user_id, :integer
    field :email, :string
    field :author_name, :string
    field :title, :string
    field :body, :string
    field :slug, :string

    timestamps
  end

  @required_fields ~w(user_id email author_name title body slug)
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
