defmodule Scan.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
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

  def signup_changeset(params) do
    %__MODULE__{}
    |> cast(params, [:email, :password])
    |> validate_email()
    |> validate_password()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_email(:email)
    |> unsafe_validate_unique(:email, Scan.Repo)
    |> unique_constraint(:email)
  end

  defp validate_email(changeset, field) do
    changeset
    |> validate_format(field, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(field, max: 160)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 12, max: 80)
    |> hash_password()
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password)

    changeset
    |> put_change(:hash_password, Bcrypt.hash_pwd_salt(password))
    |> delete_change(:password)
  end
end
