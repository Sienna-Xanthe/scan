defmodule Scan.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :hash_password, :string

    has_many :cameras, Scan.Accounts.Camera
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :hash_password])
    |> validate_required([:email, :hash_password])
  end
end
