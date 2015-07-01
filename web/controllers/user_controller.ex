defmodule ElixirStream.UserController do
  use ElixirStream.Web, :controller
  alias ElixirStream.User

  plug :redirect_if_authenticated when action in [:register, :register_form, :log_in, :log_in_form]
  plug :scrub_params, "user" when action in [:create, :update]

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", users: users
  end

  def log_in_form(conn, _params) do
    render conn, "log_in_form.html"
  end

  def log_in(conn, %{"log_in_info" => %{"username" => username, "password" => password}}) do
    case ElixirStream.LoginAction.check_username_and_password(username, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "You have logged in!")
        |> put_session(:user_id, user.id)
        |> redirect(to: entry_path(conn, :index))
      :error ->
        conn
        |> put_flash(:info, "No such login or password")
        |> redirect(to: user_path(conn, :log_in_form))
    end
  end


  def sign_out(conn, _params) do
    conn
    |> put_flash(:info, "You have logged out!")
    |> delete_session(:user_id)
    |> redirect(to: entry_path(conn, :index))
  end

  def register_form(conn, _params) do
    render(conn, "register_form.html", changeset: User.changeset(%User{}))
  end


  def register_form(conn, _register) do
    render(conn, "register_form.html", changeset: User.changeset(%User{}))
  end

  def register(conn, %{"user" => user_params}) do
    case ElixirStream.RegisterAction.sign_up(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "You have signed up and logged in!")
        |> put_session(:user_id, user.id)
        |> redirect(to: entry_path(conn, :index))
      {:error, changeset} ->
        conn
        |> render("register_form.html", changeset: changeset)
    end
  end


  def redirect_if_authenticated(conn, opts) do
    if conn.assigns[:current_user] do
      conn
      |> put_flash(:info, "You have already logged in!")
      |> redirect(to: entry_path(conn, :index))
    end
    conn
  end
end
