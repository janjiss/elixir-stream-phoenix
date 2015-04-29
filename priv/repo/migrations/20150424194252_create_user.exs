defmodule ElixirStream.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password_digest, :string
      add :email, :string

      timestamps
    end
  end
end
