defmodule ElixirStream.Router do
  use ElixirStream.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :check_authentication do
    plug ElixirStream.Plugs.CheckAuthentication
  end

  scope "/", ElixirStream do
    pipe_through :browser # Use the default browser stack
    pipe_through :check_authentication
    get "sitemap", SitemapController, :index
    get "/", EntryController, :index
    get "register_form", UserController, :register_form
    post "register", UserController, :register
    get "log_in_form", UserController, :log_in_form
    post "log_in", UserController, :log_in
    get "sign_out", UserController, :sign_out
    get "about", PageController, :about
    resources "entries", EntryController
  end

  scope "/rss", ElixirStream do
    get "/", FeedController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirStream do
  #   pipe_through :api
  # end
end
