defmodule ElixirStream.Repo.Migrations.CreateEntry do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :user_id, :integer
      add :email, :string
      add :author_name, :string
      add :title, :string
      add :body, :text
      add :slug, :string

      timestamps
    end
    create index(:entries, [:slug])
  end
end
