defmodule Scan.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Scan.Repo

  alias Scan.Accounts.User
  alias Scan.Accounts.Camera

  def get_user!(id), do: Repo.get!(User, id)
  def get_resource_by_id(id), do: Repo.get(User, id)

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

  @doc """
  camera
  """
  def create_camera(params) do
    params
    |> Camera.create_changeset()
    |> Repo.insert()
  end
end
