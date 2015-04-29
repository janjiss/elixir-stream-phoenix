defmodule ElixirStream.LoginActionTest do
  use ExUnit.Case, async: true
  alias ElixirStream.LoginAction
  alias ElixirStream.Repo
  alias ElixirStream.User


  setup do
    post = Repo.insert(%User{email: "janjiss@gmail.com", username: "janjiss", password_digest: "$2b$12$fCTLQAs1jrCXjLiDdtFu2uNETWSaM6ae6G4GEOt6XFEFt23EBDRN6"})
    # $2b$1... is equal to qwerty123
    on_exit fn ->
      Repo.delete(post)
    end
    :ok
  end

  test "It returns an error if there is a user in database, but passwords don't match" do
    assert(:error == LoginAction.check_username_and_password("janjiss", "wrong_pass"))
  end

  test "It returns an error if there is no such user in database" do
    assert(:error == LoginAction.check_username_and_password("not_present_user", "qwerty123"))
  end

  test "It returns a user if username is present and passwords match" do
    assert({:ok, %User{email: "janjiss@gmail.com"}} = LoginAction.check_username_and_password("janjiss", "qwerty123"))
  end
end
