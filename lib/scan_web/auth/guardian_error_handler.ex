defmodule ScanWeb.Auth.GuardianErrorHandler do
  import Plug.Conn

  @status_codes %{
    :token_expired => 401,
    :token_revoked => 401,
    :token_invalid => 401,
    :no_token => 401,
    :invalid_claims => 401,
    :invalid_header => 400,
    :no_secret_key => 500,
    :jwt_decode_error => 500
  }

  def auth_error(conn, {type, _reason}, _opts) do
    status_code = Map.get(@status_codes, type, 500)
    body = Jason.encode!(%{error: to_string(type)})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status_code, body)
  end
end
