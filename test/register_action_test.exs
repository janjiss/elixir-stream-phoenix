defmodule ElixirStream.RegisterActionTest do
  use ExUnit.Case, async: true
  alias ElixirStream.RegisterAction
  alias ElixirStream.Repo
  alias ElixirStream.User


  setup do
    # user = Repo.insert(%User{email: "janjiss@gmail.com", username: "janjiss", password_digest: "$2b$12$fCTLQAs1jrCXjLiDdtFu2uNETWSaM6ae6G4GEOt6XFEFt23EBDRN6"})
    # # $2b$1... is equal to qwerty123
    on_exit fn ->
      Repo.delete_all(User)
    end
    :ok
  end

  test "User persistance and saving" do
    case RegisterAction.sign_up(%{"username" => "janjiss", "email" => "janjiss@gmail.com", "password" => "qwerty123"}) do
      {:ok, %User{} = user} ->
        assert(user.email == "janjiss@gmail.com")
        assert(user.username == "janjiss")
        assert(Comeonin.Bcrypt.checkpw("qwerty123", user.password_digest))
    end
  end

  test "username too short" do
    case RegisterAction.sign_up(%{"username" => "janj", "email" => "janjiss@gmail.com", "password" => "qwerty123"}) do
      {:error, %Ecto.Changeset{} = changeset} ->
        assert(changeset.errors == [username: {"should be at least %{count} characters", 5}])
    end
  end

  test "password too short" do
    case RegisterAction.sign_up(%{"username" => "janjiss", "email" => "janjiss@gmail.com", "password" => "qwer"}) do
      {:error, %Ecto.Changeset{} = changeset} ->
        assert(changeset.errors == [password: {"should be at least %{count} characters", 8}])
    end
  end

  test "username already present" do
    Repo.insert(%User{username: "janjiss"})
    case RegisterAction.sign_up(%{"username" => "janjiss", "email" => "janjiss@gmail.com", "password" => "qwerty123"}) do
      {:error, %Ecto.Changeset{} = changeset} ->
        assert(changeset.errors == [username: "has already been taken"])
    end
  end

  test "email already present" do
    Repo.insert(%User{email: "janjiss@gmail.com"})
    case RegisterAction.sign_up(%{"username" => "janjiss", "email" => "janjiss@gmail.com", "password" => "qwerty123"}) do
      {:error, %Ecto.Changeset{} = changeset} ->
        assert(changeset.errors == [email: "has already been taken"])
    end
  end

  test "email format wrong" do
    case RegisterAction.sign_up(%{"username" => "janjiss", "email" => "janjissgmail.com", "password" => "qwerty123"}) do
      {:error, %Ecto.Changeset{} = changeset} ->
        assert(changeset.errors == [email: "has invalid format"])
    end
  end
end
