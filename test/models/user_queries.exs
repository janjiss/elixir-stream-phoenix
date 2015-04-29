defmodule ElixirStream.UserQueriesTest do
  use ElixirStream.UserQueries

  test "GET /" do
    conn = get conn(), "/"
    assert conn.resp_body =~ "Welcome to Phoenix!"
  end
end
