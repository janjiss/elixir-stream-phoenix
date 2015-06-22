defmodule ElixirStream.UserTest do
  use ElixirStream.ModelCase
  alias ElixirStream.User
  alias ElixirStream.Repo

  @valid_attrs %{"username" => "janjiss", "email" => "janjiss@gmail.com", "password" => "qwerty123"}

  test "User persistance and saving" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "User set password_digest" do
    changeset =  User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?

    user = Repo.insert(changeset)
    password_digest = User.crypt_password(user.password)
    assert(Comeonin.Bcrypt.checkpw("qwerty123", user.password_digest))
  end

  test "username too short" do
    attrs = %{@valid_attrs | "username" => "janj"}
    assert {:username, {"should be at least %{count} characters", 5}} in errors_on(%User{}, attrs)
  end

  test "password too short" do
    attrs = %{@valid_attrs | "password" => "qwer"}
    assert {:password, {"should be at least %{count} characters", 8}} in errors_on(%User{}, attrs)
  end

  test "username already present" do
    changeset =  User.changeset(%User{}, @valid_attrs)
    Repo.insert(changeset)
    assert {:username, "has already been taken"} in errors_on(%User{}, @valid_attrs)
  end

  test "email already present" do
    changeset =  User.changeset(%User{}, @valid_attrs)
    Repo.insert(changeset)
    assert {:username, "has already been taken"} in errors_on(%User{}, @valid_attrs)
  end

  test "email format wrong" do
    attrs = %{@valid_attrs | "email" => "janjissgmail.com"}
    assert {:email, "has invalid format"} in errors_on(%User{}, attrs)
  end
end
