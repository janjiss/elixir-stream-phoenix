defmodule ElixirStream.UserControllerTest do
  use ElixirStream.ConnCase

  test "/sign_up" do
    conn = post conn(), "/sign_up"
    assert conn.resp_body =~ "You have signed in!"
  end
end
