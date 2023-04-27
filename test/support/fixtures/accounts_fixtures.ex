defmodule Scan.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Scan.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        hash_password: "some hash_password"
      })
      |> Scan.Accounts.create_user()

    user
  end

  @doc """
  Generate a camera.
  """
  def camera_fixture(attrs \\ %{}) do
    {:ok, camera} =
      attrs
      |> Enum.into(%{
        camera_address: "some camera_address",
        camera_password: "some camera_password",
        camera_url: "some camera_url"
      })
      |> Scan.Accounts.create_camera()

    camera
  end

  @doc """
  Generate a plate.
  """
  def plate_fixture(attrs \\ %{}) do
    {:ok, plate} =
      attrs
      |> Enum.into(%{
        plate_color: "some plate_color",
        plate_img: "some plate_img",
        plate_number: "some plate_number"
      })
      |> Scan.Accounts.create_plate()

    plate
  end
end
