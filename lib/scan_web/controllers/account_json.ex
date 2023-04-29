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

  def index_camera(%{cameras: cameras}) do
    %{data: for(camera <- cameras, do: show_camera(%{camera: camera}))}
  end

  def show_camera(%{camera: camera}) do
    %{
      camera_id: camera.id,
      camera_address: camera.camera_address,
      camera_password: camera.camera_password,
      camera_url: camera.camera_url,
      camera_time: camera.inserted_at
    }
  end

  def index_plate(%{plates: plates}) do
    %{data: for(plate <- plates, do: show_plate(%{plate: plate}))}
  end

  def show_plate(%{plate: plate}) do
    %{
      plate_id: plate.id,
      plate_color: plate.plate_color,
      plate_img: plate.plate_img,
      plate_number: plate.plate_number,
      camera_id: plate.camera_id,
      plate_time: plate.inserted_at
    }
  end
end
