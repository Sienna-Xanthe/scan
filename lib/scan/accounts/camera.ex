defmodule Scan.Accounts.Camera do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cameras" do
    field :camera_address, :string
    field :camera_password, :string
    field :camera_url, :string
    belongs_to :user, Scan.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(camera, attrs) do
    camera
    |> cast(attrs, [:camera_password, :camera_address, :camera_url])
    |> validate_required([:camera_password, :camera_address, :camera_url])
  end
end
