defmodule ElixirStream.Repo.Migrations.AddTwitterToEntries do
  use Ecto.Migration

  def change do
    alter table(:entries) do
      add :tweet_message, :text
      add :scheduled_time, :datetime, default: fragment("now()")
      add :tweet_posted, :boolean, default: false
    end
    create index(:entries, [:scheduled_time])
  end
end
