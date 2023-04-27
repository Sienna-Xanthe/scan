defmodule ScanWeb.AccountController do
  use ScanWeb, :controller

  alias Scan.Accounts

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
end
