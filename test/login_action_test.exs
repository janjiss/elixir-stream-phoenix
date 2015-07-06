defmodule ElixirStream.LoginActionTest do
  use ElixirStream.ModelCase
  alias ElixirStream.LoginAction
  alias ElixirStream.Repo
  alias ElixirStream.User

  @valid_attrs %{"username" => "janjiss", "email" => "janjiss@gmail.com", "password" => "qwerty123"}

  test "It returns an error if there is a user in database, but passwords don't match" do
    User.changeset(%User{}, @valid_attrs) |> Repo.insert!
    assert(:error == LoginAction.check_username_and_password(@valid_attrs["username"], "wrong_pass"))
  end

  test "It returns an error if there is no such user in database" do
    User.changeset(%User{}, @valid_attrs) |> Repo.insert!
    assert(:error == LoginAction.check_username_and_password("not_present_user", @valid_attrs["password"]))
  end

  test "It returns a user if username is present and passwords match" do
    User.changeset(%User{}, @valid_attrs) |> Repo.insert!
    assert({:ok, _user} = LoginAction.check_username_and_password(@valid_attrs["username"], @valid_attrs["password"]))
  end
end
