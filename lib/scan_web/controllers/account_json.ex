defmodule ScanWeb.AccountJSON do
  def show(%{user: user}) do
    %{
      user_id: user.id,
      email: user.email
    }
  end

  def user_token(%{user: user, token: token}) do
    %{
      user_id: user.id,
      email: user.email,
      token: token
    }
  end

  def show_camera(%{camera: camera}) do
    %{
      camera_id: camera.id,
      camera_address: camera.camera_address,
      camera_password: camera.camera_password,
      camera_url: camera.camera_url
    }
  end
end
