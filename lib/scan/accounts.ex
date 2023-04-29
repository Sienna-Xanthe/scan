defmodule Scan.Accounts do
  @moduledoc """
  The Accounts context.
  """
  @base_url System.get_env("RENDER_EXTERNAL_HOSTNAME") || System.get_env("PHX_HOST") || "http://127.0.0.1:4000"

  import Ecto.Query, warn: false
  alias Scan.Repo

  alias Scan.Accounts.User
  alias Scan.Accounts.Camera
  alias Scan.Accounts.Plate
  alias Scan.Accounts.UserToken

  def get_user!(id), do: Repo.get!(User, id)
  def get_resource_by_id(id), do: Repo.get(User, id)

  def deliver_confirmation(user) do
    {encode_token, user_token} = UserToken.build_email_token(user, "confirm")
    Repo.insert(user_token)

    Scan.AccountEmail.deliver_confirmation_instructions(
      user,
      confirm_url(:confirm, encode_token)
    )
  end

  defp confirm_url(type, token) do
    case type do
      :confirm ->
        @base_url <> "/confirm/#{token}"

      :reset ->
        @base_url <> "/reset/#{token}"
    end
  end

  def create(params) do
    params
    |> User.signup_changeset()
    |> Repo.insert()
  end

  def get_user_by_email(email) do
    User
    |> where(email: ^email)
    |> Repo.one()
    |> case do
      nil -> :error
      user -> {:ok, user}
    end
  end

  def confirm_user(token) do
    UserToken
    |> where(token: ^token)
    |> Repo.one()
  end

  def confirm_update_user(email) do
    User
    |> where(email: ^email)
    |> Repo.one()
    |> User.update_changeset(%{validated: true})
    |> Repo.update()
  end

  @doc """
  camera
  """
  def create_camera(params) do
    params
    |> Camera.create_changeset()
    |> Repo.insert()
  end

  def get_camera_by_id(id) do
    Camera
    |> where(id: ^id)
    |> Repo.one()
    |> case do
      nil -> :error
      camera -> {:ok, camera}
    end
  end

  def update_camera(camera, params) do
    camera
    |> Camera.update_changeset(params)
    |> Repo.update()
  end

  @doc """
  plate
  """
  def get_plate!(id), do: Repo.get!(Plate, id)

  def create_plate(params) do
    params
    |> Plate.create_changeset()
    |> Repo.insert()
  end

  def index_plate(camera_id) do
    Plate
    |> where(camera_id: ^camera_id)
    |> Repo.all()
  end

  def delete_plate(%Plate{} = plate) do
    Repo.delete(plate)
  end
end
