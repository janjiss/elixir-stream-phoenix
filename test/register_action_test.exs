defmodule ElixirStream.RegisterActionTest do
  use ElixirStream.ModelCase
  alias ElixirStream.RegisterAction

  @valid_attrs %{"username" => "janjiss", "email" => "janjiss@gmail.com", "password" => "qwerty123"}

  test "when succsess return ok key" do
    assert({:ok, _} = RegisterAction.sign_up(@valid_attrs))
  end

  test "when error returns error key" do
    attrs = %{@valid_attrs | "email" => "janjissgmail.com"}
    assert({:error, _} =  RegisterAction.sign_up(attrs))
  end
end
