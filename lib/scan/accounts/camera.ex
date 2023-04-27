defmodule Scan.Accounts.Camera do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cameras" do
    field :camera_address, :string
    field :password, :string, virtual: true
    field :camera_password, :string
    field :camera_url, :string
    belongs_to :user, Scan.Accounts.User

    timestamps()
  end

  @doc false
  def create_changeset(params) do
    %__MODULE__{}
    |> cast(params, [:password, :camera_address, :camera_url])
    |> validate_required([:camera_address, :camera_url])
    |> validate_password()
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 12, max: 80)
    |> hash_password()
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password)
    IO.inspect(changeset)

    changeset
    |> put_change(:camera_password, Bcrypt.hash_pwd_salt(password))
    |> delete_change(:password)
    |> IO.inspect()
  end

  def update_changeset(camera, params) do
    camera
    |> cast(params, [:camera_address, :camera_url, :camera_password, :user_id])
    |> validate_required([:camera_address, :camera_url, :camera_password, :user_id])
  end
end
