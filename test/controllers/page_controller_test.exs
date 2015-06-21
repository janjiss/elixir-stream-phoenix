defmodule ElixirStream.PageControllerTest do
  use ElixirStream.ConnCase

  test "GET /register_form" do
    conn = get conn(), "/register_form"
    assert conn.resp_body =~ "Username"
  end

  test "POST /register with wrong credentials" do
    conn = post conn(), "/register"
    assert conn.resp_body =~ "Username"
  end
end
