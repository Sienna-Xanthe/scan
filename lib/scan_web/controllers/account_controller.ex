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

  ## 登陆账户
  def signin(conn, %{"email" => email, "password" => password}) do
    authorize_account(conn, email, password)
  end

  ## 生成token
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

  ## 展示当前用户信息
  def current(conn, %{}) do
    conn
    |> put_status(:ok)
    |> render(:show, user: conn.assigns[:user])
  end

  ## 初始化摄像头，也就是数据库插入设备
  def create_camera(conn, %{"camera" => params}) do
    with {:ok, camera} <- Accounts.create_camera(params) do
      conn
      |> put_status(:created)
      |> render(:show_camera, camera: camera)
    end
  end

  ## 初始化车牌，也就是数据库插入车牌记录
  def create_plate(conn, %{"plate" => params}) do
    with {:ok, plate} <- Accounts.create_plate(params) do
      conn
      |> put_status(:created)
      |> render(:show_plate, plate: plate)
    end
  end

  ## 用户添加设备
  def add_camera(conn, %{"camera_id" => camera_id, "camera_password" => camera_password}) do
    with {:ok, camera} <- Accounts.get_camera_by_id(camera_id),
         true <- Bcrypt.verify_pass(camera_password, camera.camera_password),
         {:ok, camera} <- Accounts.update_camera(camera, %{user_id: conn.assigns[:user].id}) do
      conn
      |> put_status(:created)
      |> render(:show_camera, camera: camera)
    else
      _error ->
        raise ErrorResponse.Unauthorized, message: "Camera id or password incorrect"
    end
  end

  ## 用户操作设备，包括修改密码、地址，解绑之类的
  def update_camera(conn, %{"camera_id" => camera_id, "params" => params}) do
    with {:ok, camera} <- Accounts.get_camera_by_id(camera_id),
         {:ok, camera} <- Accounts.update_camera(camera, params) do
      conn
      |> put_status(:created)
      |> render(:show_camera, camera: camera)
    else
      _error ->
        raise ErrorResponse.Unauthorized, message: "Camera id or params incorrect"
    end
  end

  ## 展示当前用户的所有设备信息
  def index_camera(conn, %{}) do
    user = conn.assigns[:user]

    conn
    |> put_status(:ok)
    |> render(:index_camera, cameras: user.camera)
  end
end
