defmodule Scan.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Scan.Repo

  alias Scan.Accounts.User

  def get_user!(id), do: Repo.get!(User, id)

  alias Scan.Accounts.Camera

  @doc """
  Returns the list of cameras.

  ## Examples

      iex> list_cameras()
      [%Camera{}, ...]

  """
  def list_cameras do
    Repo.all(Camera)
  end

  @doc """
  Gets a single camera.

  Raises `Ecto.NoResultsError` if the Camera does not exist.

  ## Examples

      iex> get_camera!(123)
      %Camera{}

      iex> get_camera!(456)
      ** (Ecto.NoResultsError)

  """
  def get_camera!(id), do: Repo.get!(Camera, id)

  @doc """
  Creates a camera.

  ## Examples

      iex> create_camera(%{field: value})
      {:ok, %Camera{}}

      iex> create_camera(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_camera(attrs \\ %{}) do
    %Camera{}
    |> Camera.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a camera.

  ## Examples

      iex> update_camera(camera, %{field: new_value})
      {:ok, %Camera{}}

      iex> update_camera(camera, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_camera(%Camera{} = camera, attrs) do
    camera
    |> Camera.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a camera.

  ## Examples

      iex> delete_camera(camera)
      {:ok, %Camera{}}

      iex> delete_camera(camera)
      {:error, %Ecto.Changeset{}}

  """
  def delete_camera(%Camera{} = camera) do
    Repo.delete(camera)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking camera changes.

  ## Examples

      iex> change_camera(camera)
      %Ecto.Changeset{data: %Camera{}}

  """
  def change_camera(%Camera{} = camera, attrs \\ %{}) do
    Camera.changeset(camera, attrs)
  end

  alias Scan.Accounts.Plate

  @doc """
  Returns the list of plate.

  ## Examples

      iex> list_plate()
      [%Plate{}, ...]

  """
  def list_plate do
    Repo.all(Plate)
  end

  @doc """
  Gets a single plate.

  Raises `Ecto.NoResultsError` if the Plate does not exist.

  ## Examples

      iex> get_plate!(123)
      %Plate{}

      iex> get_plate!(456)
      ** (Ecto.NoResultsError)

  """
  def get_plate!(id), do: Repo.get!(Plate, id)

  @doc """
  Creates a plate.

  ## Examples

      iex> create_plate(%{field: value})
      {:ok, %Plate{}}

      iex> create_plate(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_plate(attrs \\ %{}) do
    %Plate{}
    |> Plate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a plate.

  ## Examples

      iex> update_plate(plate, %{field: new_value})
      {:ok, %Plate{}}

      iex> update_plate(plate, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_plate(%Plate{} = plate, attrs) do
    plate
    |> Plate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a plate.

  ## Examples

      iex> delete_plate(plate)
      {:ok, %Plate{}}

      iex> delete_plate(plate)
      {:error, %Ecto.Changeset{}}

  """
  def delete_plate(%Plate{} = plate) do
    Repo.delete(plate)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking plate changes.

  ## Examples

      iex> change_plate(plate)
      %Ecto.Changeset{data: %Plate{}}

  """
  def change_plate(%Plate{} = plate, attrs \\ %{}) do
    Plate.changeset(plate, attrs)
  end
end
