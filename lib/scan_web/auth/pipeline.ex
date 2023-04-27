defmodule ScanWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :scan,
    module: ScanWeb.Auth.Guardian,
    error_handler: ScanWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
