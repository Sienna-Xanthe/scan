defmodule ScanWeb.AccountController do
  use ScanWeb, :controller

  alias Scan.Accounts

  ## 注册账户
  def signup(conn, %{"user" => params}) do
    with {:ok, user} <- Accounts.create(params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end
end
