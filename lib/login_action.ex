defmodule ElixirStream.LoginAction do
  alias ElixirStream.UserQueries
  alias ElixirStream.User

  def check_username_and_password(username, password) do
    case UserQueries.find_user_by_login(username) do
      %User{password_digest: password_digest} = user ->
        if Comeonin.Bcrypt.checkpw(password, password_digest) do
          user 
        else
          :error
        end
      _ -> :error
    end
  end
end
