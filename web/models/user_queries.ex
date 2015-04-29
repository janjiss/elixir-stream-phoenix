defmodule ElixirStream.UserQueries do
  import Ecto.Query
  alias ElixirStream.User

  def find_user_by_login(username) do
    query = from user in User,
    where: user.username == ^username,
    select: user
    ElixirStream.Repo.all(query) |> List.first
  end
end
