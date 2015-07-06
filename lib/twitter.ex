defmodule Twitter do
  def tweet(message) do
    ExTwitter.update(message)
  end
end
