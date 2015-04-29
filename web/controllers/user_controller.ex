defmodule ElixirStream.UserController do
  use ElixirStream.Web, :controller

  alias ElixirStream.User
  alias ElixirStream.UserQueries

  plug :scrub_params, "user" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", users: users
  end

  def log_in_form(conn, _params) do
    render conn, "log_in_form.html"
  end

  def log_in(conn, %{"log_in_info" => %{"username" => username, "password" => password}}) do
    case LoginAction.check_username_and_password(username, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "You have logged in!")
        |> redirect(to: entry_path(conn, :index))
      :not_found ->
        conn
        |> put_flash(:info, "No such login or password")
        |> redirect(to: user_path(conn, :log_in_form))
    end
  end

  def sign_up(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "User created successfully.")
      |> redirect(to: user_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end


  def edit(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user)
    render conn, "edit.html", user: user, changeset: changeset
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, user_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "User updated successfully.")
      |> redirect(to: user_path(conn, :index))
    else
      render conn, "edit.html", user: user, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    Repo.delete(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
