defmodule ElixirStream.UserControllerTest do
  use ElixirStream.ConnCase

  test "GET /register_form" do
    conn = get conn(), "/register_form"
    assert conn.resp_body =~ "Username"
  end

  test "POST /registers" do
    # TO DO need fix!!!
    # conn = post conn(), "/register"
    # assert conn.resp_body =~ "Username"
  end
end
