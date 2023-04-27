defmodule ScanWeb.Router do
  use ScanWeb, :router
  use Plug.ErrorHandler

  def handle_errors(conn, params) do
    handle_errors_format(conn, params)
  end

  defp handle_errors_format(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors_format(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ScanWeb.Auth.Pipeline
    plug ScanWeb.Auth.SetAccount
  end

  scope "/api", ScanWeb do
    pipe_through :api
    post "/accounts/signup", AccountController, :signup
    post "/accounts/signin", AccountController, :signin
  end

  scope "/api", ScanWeb do
    pipe_through [:api, :auth]
    get "/accounts/current", AccountController, :current
    post "/accounts/add_camera", AccountController, :add_camera
    post "/accounts/update_camera", AccountController, :update_camera
  end

  scope "/api", ScanWeb do
    pipe_through :api
    post "/admin/camera", AccountController, :create_camera
    post "/admin/plate/", AccountController, :create_plate
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:scan, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ScanWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
