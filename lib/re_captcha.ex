defmodule ElixirStream.ReCaptcha do
  def verify(%Plug.Conn{remote_ip: remote_ip, params: %{"g-recaptcha-response" => captcha_response}}) do
    {status, %HTTPoison.Response{body: body}} = HTTPoison.post(
    "https://www.google.com/recaptcha/api/siteverify",
      {:multipart,
        [
          {"response", captcha_response},
          {"remoteip", Enum.join(Tuple.to_list(remote_ip), ".")},
          {"secret", Application.get_env(:elixir_stream, :captcha)[:secret]}
        ]}
      )
      if String.contains? body, "\"success\": true" do
        :ok
      else
        {:error, "Captcha validation failed"}
      end
  end
end
