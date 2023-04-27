defmodule ScanWeb.AccountController do
  use ScanWeb, :controller

  alias Scan.Accounts
  alias ScanWeb.Auth.Guardian
  alias ScanWeb.Auth.ErrorResponse

  # 如果发生conn错误也就是说没有找到对应的action，那么就会调用FallbackController的call方法
  action_fallback ScanWeb.FallbackController

  ## 注册账户
  def signup(conn, %{"user" => params}) do
    with {:ok, user} <- Accounts.create(params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end

  def signin(conn, %{"email" => email, "password" => password}) do
    authorize_account(conn, email, password)
  end

  defp authorize_account(conn, email, password) do
    case Guardian.authenticate(email, password) do
      {:ok, user, token} ->
        conn
        |> put_status(:ok)
        |> render(:user_token, %{user: user, token: token})

      {:error, :unauthorized} ->
        raise ErrorResponse.Unauthorized, message: "Email or password incorrect"
    end
  end
end
