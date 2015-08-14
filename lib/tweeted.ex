defmodule ElixirStream.Tweeted do
  alias ElixirStream.Entry
  alias ElixirStream.Repo

  def tweeted(%Entry{} = entry) do
      changeset = Entry.changeset_with_admin(entry, %{tweet_posted: true})
    if changeset.valid? do
      Repo.update(changeset)
      ExTwitter.update(entry.tweet_message)
    else
      false
    end
  end
end
